/*****************************************
 *  所有版权(c) 上海塔齐通讯技术有限公司       *
 *****************************************/
package com.touch.sysif.sms.api.client;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.touch.sysif.sms.api.model.SmsMessage;
import com.touch.sysif.sms.api.model.SmsReport;
import com.touch.sysif.sms.api.model.SubSmsMessage;

/**
 * 
 * @version $Revision: 1.0 $
 * @author yanxiao
 * @date: Jan 22, 2014
 * @time: 12:45:00 AM
 */
public class HttpSmsClient extends AbstractSmsClient {
	protected String httpHost;
	protected DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Override
	public void init(String configFile) {
		super.init(configFile);
		httpHost = config.getProperty("http.host");
	}
	/**
	 * @see com.touch.sysif.sms.api.SmsClient#activeTest()
	 */
	@Override
	public void activeTest() {

	}

	/**
	 * @see com.touch.sysif.sms.api.SmsClient#batchSend(com.touch.sysif.sms.api.model.SmsMessage[])
	 */
	@Override
	public String[] batchSend(SmsMessage[] message) {
		if (message != null) {
			String[] ids = new String[message.length];
			for (int i = 0; i < ids.length; i++) {
				ids[i] = send(message[i]);
			}
			return ids;
		}
		return null;
	}

	/**
	 * @see com.touch.sysif.sms.api.SmsClient#getSmsMessage()
	 */
	@Override
	public SmsMessage[] getSmsMessage() {
		Map<String,String> parameterMap = new HashMap<String, String>();
		parameterMap.put("username", username);
		parameterMap.put("password", password);
		JSONObject rsp = post(this.httpHost + "/api/http/GetSmsMessage", parameterMap);
		if(rsp!=null && rsp.optInt("code") == 200){
			JSONArray messageArray = rsp.optJSONArray("messages");
			if(messageArray !=null){
				SmsMessage[] messages = new SmsMessage[messageArray.size()];
				for (int i = 0; i < messages.length; i++) {
					try {
						JSONObject messageObject = messageArray.optJSONObject(i);
						messages[i] = new SmsMessage(
								messageObject.optString("batchId"),
								messageObject.optString("content"),
								messageObject.optString("destAddr"),
								false,
								dateFormat.parse(messageObject.optString("sendTime")),
								messageObject.optString("smsParam"),
								messageObject.optString("sourceAddr")
								);
					} catch (Exception e) {
					}
				}
				return messages;
			}
		}
		return null;
	}

	/**
	 * @see com.touch.sysif.sms.api.SmsClient#getSmsReports(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public SmsReport[] getSmsReports(String batchId, String destAddr) {
		Map<String,String> parameterMap = new HashMap<String, String>();
		parameterMap.put("username", username);
		parameterMap.put("password", password);
		if(batchId !=null){
			parameterMap.put("batchId", batchId);
		}
		if(destAddr != null){
			parameterMap.put("destAddr", destAddr);
		}
		JSONObject rsp = post(this.httpHost + "/api/http/GetSmsReports", parameterMap);
		if(rsp!=null && rsp.optInt("code") == 200){
			JSONArray smsRptArray = rsp.optJSONArray("smsRpts");
			if(smsRptArray !=null){
				SmsReport[] smsRpts = new SmsReport[smsRptArray.size()];
				for (int i = 0; i < smsRpts.length; i++) {
					try {
						JSONObject smsRptObject = smsRptArray.optJSONObject(i);
						smsRpts[i] = new SmsReport(
								smsRptObject.optString("batchId"),
								smsRptObject.optString("destAddr"),
								null,
								dateFormat.parse(smsRptObject.optString("receivedTime")),
								smsRptObject.optString("sourceAddr"),
								smsRptObject.optInt("statusCode"),
								smsRptObject.optString("statusText")
						); 
						JSONArray submsgArray = smsRptObject.optJSONArray("message");
						if(submsgArray !=null){
							SubSmsMessage[] submsgs = new SubSmsMessage[submsgArray.size()];
							for (int j = 0; j < submsgs.length; j++) {
								JSONObject subMsg = submsgArray.optJSONObject(j);
								submsgs[j] = new SubSmsMessage(
										subMsg.optString("batchId"),
										subMsg.optString("content"),
										subMsg.optString("destAddr"),
										(short)subMsg.optInt("pkNumber"),
										(short)subMsg.optInt("pkTotal"),
										subMsg.optString("sourceAddr"),
										subMsg.optInt("statusCode")
								);
							}
							smsRpts[i].setMessage(submsgs );
						}
					} catch (Exception e) {
					}
				}
				return smsRpts;
			}
		}
		return null;
	}

	/**
	 * @see com.touch.sysif.sms.api.SmsClient#send(com.touch.sysif.sms.api.model.SmsMessage)
	 */
	@Override
	public String send(SmsMessage message) {
		Map<String,String> parameterMap = new HashMap<String, String>();
		parameterMap.put("username", username);
		parameterMap.put("password", password);
		parameterMap.put("destAddr", message.getDestAddr());
		parameterMap.put("content", message.getContent());
		parameterMap.put("reqReport", String.valueOf(message.getReqReport()));
		parameterMap.put("sourceAddr", message.getSourceAddr());
		Date sendTime = message.getSendTime();
		if(sendTime !=null){
			parameterMap.put("sendTime", dateFormat.format(sendTime));
		}
		JSONObject rsp = post(this.httpHost + "/api/http/SendSmsMessage", parameterMap);
		if(rsp!=null && rsp.optInt("code") == 200){
			return rsp.optString("batchId");
		}
		return null;
	}

	JSONObject post(String url,Map<String,String> parameterMap) {
		StringBuffer rsp = new StringBuffer();
		HttpURLConnection connection = null;
		DataOutputStream out = null;
		InputStream is =null;
		InputStreamReader isr = null;
		BufferedReader br = null;
		try {
			connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setRequestMethod("POST");
			connection.setUseCaches(false);
			connection.setInstanceFollowRedirects(true);
			connection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
			StringBuffer content = new StringBuffer();
			Set<String> parameterKeySet = parameterMap.keySet();
			for (String parameterKey : parameterKeySet) {
				String value =  parameterMap.get(parameterKey);
				if(content.length() >0){
					content.append("&");
				}
				content.append(parameterKey);
				content.append("=");
				content.append(URLEncoder.encode(value, "utf-8"));
			}
			out = new DataOutputStream(connection.getOutputStream());
			out.writeBytes(content.toString());
			out.flush();
			is = connection.getInputStream();
			isr = new InputStreamReader(is,"utf-8");
			br = new BufferedReader(isr);
			String line = null;
			while ((line = br.readLine()) != null) {
				rsp.append(line);
			}
		} catch (Exception e) {
			System.out.println("发送请求失败:" + e.getMessage());
		}finally{
			if(out !=null){
				try {
					out.close();
				} catch (IOException e) {
				}
			}
			if(br !=null){
				try {
					br.close();
				} catch (IOException e) {
				}
			}
			if(isr !=null){
				try {
					isr.close();
				} catch (IOException e) {
				}
			}
			if(is !=null){
				try {
					is.close();
				} catch (IOException e) {
				}
			}
			if(connection !=null){
				connection.disconnect();
			}
		}
		String rspString = rsp.toString();
		if(rspString.startsWith("{") && rspString.endsWith("}")){
			return JSONObject.fromObject(rsp.toString());
		}
		return null;
	}
}
