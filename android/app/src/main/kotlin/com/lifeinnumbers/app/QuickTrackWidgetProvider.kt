package com.lifeinnumbers.app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.widget.RemoteViews
import android.widget.Toast
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONObject
import java.util.UUID

object QuickTrackActionStore {
    private const val preferencesName = "quick_track_pending_actions"
    private const val prefix = "action_"

    @Synchronized
    fun add(context: Context, kind: String, targetId: String): Boolean {
        val id = "widget_${UUID.randomUUID()}"
        val action = JSONObject()
            .put("id", id)
            .put("kind", kind)
            .put("targetId", targetId)
            .put("timestamp", System.currentTimeMillis())
            .toString()

        return context.getSharedPreferences(preferencesName, Context.MODE_PRIVATE)
            .edit()
            .putString("$prefix$id", action)
            .commit()
    }

    @Synchronized
    fun pending(context: Context): List<Map<String, Any>> {
        val preferences = context.getSharedPreferences(preferencesName, Context.MODE_PRIVATE)
        return preferences.all
            .filterKeys { it.startsWith(prefix) }
            .mapNotNull { (_, value) ->
                try {
                    val json = JSONObject(value as String)
                    mapOf(
                        "id" to json.getString("id"),
                        "kind" to json.getString("kind"),
                        "targetId" to json.getString("targetId"),
                        "timestamp" to json.getLong("timestamp")
                    )
                } catch (_: Exception) {
                    null
                }
            }
            .sortedWith(compareBy({ it["timestamp"] as Long }, { it["id"] as String }))
    }

    @Synchronized
    fun acknowledge(context: Context, id: String): Boolean {
        if (!id.startsWith("widget_")) return false
        return context.getSharedPreferences(preferencesName, Context.MODE_PRIVATE)
            .edit()
            .remove("$prefix$id")
            .commit()
    }
}

class QuickTrackActionReceiver : BroadcastReceiver() {
    companion object {
        private val feedbackTokens = mutableMapOf<String, String>()
        private const val feedbackDuration = 1200L
    }

    override fun onReceive(context: Context, intent: Intent) {
        val kind = intent.getStringExtra("kind") ?: return
        val targetId = intent.getStringExtra("targetId") ?: return
        val label = intent.getStringExtra("label") ?: return
        val widgetId = intent.getIntExtra(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        )
        val viewId = intent.getIntExtra("viewId", -1)

        if (kind != "moment" && kind != "feeling") return
        if (targetId.isBlank()) return
        if (widgetId == AppWidgetManager.INVALID_APPWIDGET_ID) return
        if (viewId !in listOf(
                R.id.widget_moment_1,
                R.id.widget_moment_2,
                R.id.widget_feeling_1,
                R.id.widget_feeling_2
            )
        ) return

        val pendingResult = goAsync()

        try {
            val saved = QuickTrackActionStore.add(context, kind, targetId)
            if (!saved) {
                Toast.makeText(context, "Could not save record", Toast.LENGTH_SHORT).show()
                pendingResult.finish()
                return
            }

            val manager = AppWidgetManager.getInstance(context)
            val feedbackKey = "$widgetId:$viewId"
            val feedbackToken = UUID.randomUUID().toString()

            synchronized(feedbackTokens) {
                feedbackTokens[feedbackKey] = feedbackToken
            }

            val feedbackViews = RemoteViews(
                context.packageName,
                R.layout.quick_track_widget
            ).apply {
                setTextViewText(viewId, "✓ Recorded!")
                setTextColor(viewId, Color.rgb(52, 107, 73))
            }

            manager.partiallyUpdateAppWidget(widgetId, feedbackViews)

            Handler(Looper.getMainLooper()).postDelayed({
                try {
                    val shouldRestore = synchronized(feedbackTokens) {
                        if (feedbackTokens[feedbackKey] == feedbackToken) {
                            feedbackTokens.remove(feedbackKey)
                            true
                        } else {
                            false
                        }
                    }

                    if (shouldRestore) {
                        val restoreViews = RemoteViews(
                            context.packageName,
                            R.layout.quick_track_widget
                        ).apply {
                            setTextViewText(viewId, label)
                            setTextColor(viewId, Color.rgb(38, 59, 86))
                        }
                        manager.partiallyUpdateAppWidget(widgetId, restoreViews)
                    }
                } catch (error: Exception) {
                    Log.e("QuickTrack", "Could not restore widget feedback", error)
                } finally {
                    pendingResult.finish()
                }
            }, feedbackDuration)
        } catch (error: Exception) {
            Log.e("QuickTrack", "Widget action failed", error)
            pendingResult.finish()
        }
    }
}

class QuickTrackWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.quick_track_widget)

            bindCard(context, views, widgetData, widgetId, 1, R.id.widget_moment_1, "moment_1", "moment", "Moment")
            bindCard(context, views, widgetData, widgetId, 2, R.id.widget_moment_2, "moment_2", "moment", "Moment")
            bindCard(context, views, widgetData, widgetId, 3, R.id.widget_feeling_1, "feeling_1", "feeling", "Feeling")
            bindCard(context, views, widgetData, widgetId, 4, R.id.widget_feeling_2, "feeling_2", "feeling", "Feeling")

            val dashboardIntent = HomeWidgetLaunchIntent.getActivity(
                context,
                MainActivity::class.java
            )
            views.setOnClickPendingIntent(R.id.widget_open_dashboard, dashboardIntent)
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

    private fun bindCard(
        context: Context,
        views: RemoteViews,
        data: SharedPreferences,
        widgetId: Int,
        slot: Int,
        viewId: Int,
        key: String,
        kind: String,
        fallback: String
    ) {
        val name = data.getString("${key}_name", fallback) ?: fallback
        val targetId = data.getString("${key}_id", "") ?: ""

        views.setTextViewText(viewId, name)
        views.setTextColor(viewId, Color.rgb(38, 59, 86))

        if (targetId.isNotBlank()) {
            val intent = Intent(context, QuickTrackActionReceiver::class.java).apply {
                putExtra("kind", kind)
                putExtra("targetId", targetId)
                putExtra("label", name)
                putExtra("viewId", viewId)
                putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
            }

            val pendingIntent = PendingIntent.getBroadcast(
                context,
                widgetId * 10 + slot,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )

            views.setOnClickPendingIntent(viewId, pendingIntent)
        } else {
            views.setOnClickPendingIntent(viewId, null)
        }
    }
}
