package com.kgk.eisprime

import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import android.view.WindowManager.LayoutParams;

class MainActivity: FlutterActivity(){

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        getWindow().addFlags(LayoutParams.FLAG_SECURE);
        super.onCreate(savedInstanceState, persistentState)
    }

}
