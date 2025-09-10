package com.unistal.mdpe_approve_app

import android.os.Bundle
import com.google.android.play.core.appupdate.AppUpdateManagerFactory
import com.google.android.play.core.install.model.AppUpdateType
import com.google.android.play.core.install.model.UpdateAvailability
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val METHOD_CHANNEL = "mgl/mglmdpeapproval"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val appUpdateManager = AppUpdateManagerFactory.create(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
            .setMethodCallHandler { request: MethodCall, response: MethodChannel.Result ->
                if (request.method == "getAppUpdate") {
                    val appUpdateInfoTask = appUpdateManager.appUpdateInfo
                    appUpdateInfoTask.addOnSuccessListener { appUpdateInfo ->
                        if (appUpdateInfo.updateAvailability() == UpdateAvailability.UPDATE_AVAILABLE &&
                            appUpdateInfo.isUpdateTypeAllowed(AppUpdateType.IMMEDIATE)
                        ) {
                            response.success("success")
                        } else {
                            response.success("fail")

                        }
                    }.addOnFailureListener { e ->
                        response.error("ERROR", "Failed to check updates: ${e.message}", null)
                    }
                }
            }
    }
}
