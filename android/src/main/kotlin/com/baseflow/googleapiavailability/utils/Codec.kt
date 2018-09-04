package com.baseflow.googleapiavailability.utils

import com.baseflow.googleapiavailability.data.PlayServicesAvailability
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken

class Codec {
    companion object {
        @JvmStatic
        private val gsonDecoder : Gson = GsonBuilder().enableComplexMapKeySerialization().create()

        @JvmStatic
        fun encodePlayServicesAvailability(availability: PlayServicesAvailability) : String {
            return gsonDecoder.toJson(availability)
        }
    }
}