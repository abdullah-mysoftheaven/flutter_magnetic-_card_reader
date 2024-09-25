package com.example.smartposplugin;
import com.google.gson.Gson;

import java.util.HashMap;
import java.util.Map;

public class ResponseData {

    public void setResponse(String response) {
        this.response = response;
    }

    public void setResult(int result) {
        this.result = result;
    }


    public void setEmvResult(int emvResult) {
        EmvResult = emvResult;
    }

    public void setTrack1(String track1) {
        this.Track1 = track1;
    }

    public void setTrack2(String track2) {
        this.Track2 = track2;
    }

    public void setTrack3(String track3) {
        this.Track3 = track3;
    }

    private int result=0;
    private String response="";
    private int EmvResult=-1;
    private String Track1="";
    private String Track2="";
    private String Track3="";

    public void setReponsebytes(byte[] reponsebytes) {
        this.reponsebytes = reponsebytes;
    }

    private byte[] reponsebytes;


    // 构造函数
    public ResponseData() {

    }


    String getResponseStr(){

        String resp="";
        Gson gson = new Gson();
        String json = gson.toJson(this);

        return  json;

    }




}
