// Common Variables ...
var sAlphabet   = String( "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" ); //英文字母
var sSpace      = String( " " );  						//定义空格	
var sSpecial    = String( "_-()/[]<>.," );					//定义分隔符
var sFileName   = String( "~!@#$%&()_-+={}[]\\',./" );				//定义文件名可包括字符
var sNormalText = String( "_-()/[]<>.,'" );					//普通字符串包括字符
var sInteger    = String( "0123456789" );					//数字
var sDecimal    = String( ".0123456789" );					//小数
var sDateSep    = "-";								//定义日前分隔符
var sTimeSep    = ":";								//时间分隔符
var sPositive   = "1";						
var sAll        = "0";
var sNegative   = "-1"
var sMaxDecimal = "4";
var iDateDay    = 2;
var iDateMonth  = 1;
var iDateYear   = 0;


function showError(sErrorMessage)
// Show error message 显示错误消息
    {
    alert(sErrorMessage);
    return false;
    }
	

function isEmptyString(sValue) 
// Check for Empty String value 检查是否为空值
// return TRUE if empty string, otherwise return FALSE.
    {
    var sEmpty = "";
  
    if (sValue == "" || sValue == null) return true;
  
    for (var i = 1; i <= sValue.length; i++)    
        {
        var sSpace = sValue.substring(i-1, i);
        if (sSpace != " ") sEmpty += sSpace;
        }

    if (sEmpty == "") return true;

    return false;
    }

    
function isValidString(sString, sPattern) 
// Check whether the string contains any character out of the pattern 检查在字符串Spattern中是否包含sString字符串
// return TRUE if is valid string, otherwise return FALSE.
    {
    var sSubstring;
    
    if (isEmptyString(sString) || isEmptyString(sPattern)) return false;
			
    for (var i = 0; i < sString.length; i++)
        {
        sSubstring = sString.charAt(i)
        if (sPattern.indexOf(sSubstring) == -1) return false;
        }
        
    return true;
    }    
    
    
function isAlphabet(sString)
// Check whether the string contains alphabet only 检查是否仅为英文字母
// return TRUE if is valid string, otherwise return FALSE.
    {
    var sAllowChar = String(sAlphabet);
    return isValidString(sString, sAllowChar);
    }


function isAlphaNumeric(sString) 
// Check whether the string contains alphanumeric character only.检查是否文字和数字型字符
// return TRUE if only AlphaNumeric, otherwise return FALSE.
    {
    var sAllowChar = String(sAlphabet) + String(sInteger);    
    return isValidString(sString, sAllowChar);
    }    
    

function isAlphaNumericSpecial(sString)
// Check whether the string contains any invalid character (non alphanumeric, "-", "_" ...) 检查字符串中是否不包括制定的分隔符
// return TRUE if is valid string, otherwise return FALSE.
    {
    var sAllowChar = String(sAlphabet) + String(sInteger) + String(sSpecial);
    return isValidString(sString, sAllowChar);
    }


function isAlphabetSpace(sString)
// Check whether the string contains alphabet or space only 检查字符串是否不包括空格
// return TRUE if is valid string, otherwise return FALSE.
    {
    var sAllowChar = String(sAlphabet) + String(sSpace);
    return isValidString(sString, sAllowChar);
    }

    
function isNormalText(sString)
// Check whether the string contains valid normal text character only 是否仅为规定的字符
// i.e. a-z, A-Z, 0-9, " _-()/[]<>.,'"
// return TRUE if is valid string, otherwise return FALSE.
    {
    var sAllowChar = String(sAlphabet) + String(sInteger) + String(sSpace) + String(sNormalText);
    return isValidString(sString, sAllowChar);
    }
    

function isFileName(sString)
// Check whether the string contains valid Filename character only 文件名是否正确
// i.e. a-z, A-Z, 0-9, " ~!@#$%&()_-+={}[]\;',./"
// return TRUE if is valid string, otherwise return FALSE.
    {
    var sAllowChar = String(sAlphabet) + String(sSpace) + String(sFileName);
    var sFileName1 = sString;
    var sFileName2 = sString.substr(sString.indexOf(".") + 1);
    
    if (!isValidString(sFileName, sAllowChar)) return false;
    
    if ( (sFileName1.indexOf(".") == -1) ||
         (sFileName1.indexOf(".") == 0 ) ||
         (sFileName1.indexOf(".") + 1 == sFileName1.length) ||
         (sFileName1.indexOf(".") != sFileName1.lastIndexOf(".")) ||
         (sFileName2.indexOf("/") != -1) )
        { return false; }
    
    return true;
    }

    
function isValidEmail(sString) 
// Check whether the string is a valid email address Email地址格式是否正确
// return TRUE if valid, otherwise return FALSE.
    {
    var sEmail1 = sString;
    var sEmail2 = sString.substr(sString.indexOf("@") + 1);
    
    if ( (sEmail1.indexOf("@") == -1) || 
         (sEmail1.indexOf(" ") != -1) ||
         (sEmail1.indexOf("@") == 0 ) ||
         (sEmail1.indexOf(".") == 0 ) ||
         (sEmail1.indexOf("@") != sEmail1.lastIndexOf("@")) ||
         (sEmail1.indexOf(".") + 1 == sEmail1.length) ||
         (sEmail2.indexOf(".") == -1) ||  
            (sEmail2.indexOf(".") == 0 ) )
        { return false; }

    return true;
    }

    
function isNumber(sValue, sPattern) 
// Check for validility of Numeric value in specific pattern 是否为数字
// return TRUE if integer, otherwise return FALSE.
    {
    var sElement = String(sValue);
    var sPattern = String(sPattern);
    var sElement;
    var sSubstring;

    if ( isEmptyString(sValue) ) return false;
    
    var sNegative = sValue.split("-");

    if (sNegative.length > 2 ) return false ;
    if (isEmptyString(sNegative[0])) sElement = String(sNegative[1]);
    if (sElement.length < 1) return false;
        
    for (var i = 0; i < sElement.length; i++)    
        {
        sSubstring = sElement.substring(i, i+1);
        if (sPattern.indexOf(sSubstring) < 0) return false;
        }

    return true;
    }


function isInteger(sValue)
// Check for validility of Integer 是否为整数
// return TRUE if integer, otherwise return FALSE.
    { 
    return isNumber(sValue, sInteger); 
    }
    

function isPositiveInteger(sValue)
// Check for validility of Positive Integer
// return TRUE if Positive integer, otherwise return FALSE.
    {
    if (sValue.indexOf("-") >= 0) return false;
    return isNumber(sValue, sInteger);
    }

    
function isDecimal(sValue) 
    {
// Check for validility of Decimal value (including integer ...)是否为小数
// return TRUE if decimal, otherwise return FALSE.

    var sInValue = String(sValue);
    var aryValue;
    var iDot = 0;
    var bDecimal = true;
    var iMinus = 0;
    
    if (isEmptyString(sInValue)) return false;
    if (sInValue.indexOf(sSpace) >= 0) return false;
    
    iMinus = sInValue.indexOf("-");
    if (iMinus > 0) 
        return false;
    else if (iMinus == 0)
        sInValue = sInValue.substr(1, sInValue.length-1);
    
    aryValue = sInValue.split(".");
    if (aryValue.length > 2 || aryValue.length <= 0) return false ;

    for (var i = 0; i < aryValue.length; i++){
        if (isEmptyString(aryValue[i]))
            iDot++;
        else if (aryValue[i].length > 0){
            if (i == 0)
                bDecimal = isInteger(aryValue[i]);
            else
                bDecimal = isPositiveInteger(aryValue[i]);
        }
            
        if (iDot > 1 || !bDecimal) return false;
    }
        
    return true;
    }

    
function isDecimalPoint(sValue, sPoint)
// Check for validility of Decimal Value with specific decimal point 是否为小数
// return TRUE if valid decimal, or return FALSE if not
    {
    var aryValue;
    var sMaximum = new String;

    sMaximum = "";
    
    if (!isDecimal(sValue)) return false;
    
    aryValue = sValue.split(".");

    if (aryValue.length > 2 || (sPoint == 0 && aryValue.length != 1)) return false;
    if (aryValue.length == 2 && aryValue[1].length > Number(sPoint))  return false; 
    
    return true;
    }

function isCurrency(sValue) 
// Check whether the string is in Currency Pattern, i.e. ###,###,###.#####
// return TRUE if valid Currency pattern, or return FALSE if not     是否为货币类型
    {
    var aryValue;
    var aryDecimal;
    var sLastPortion  = new String;
    var sReplace = /,/gi;
    
    if (sValue.indexOf(sSpace) >= 0) return false;
    if (!isDecimalPoint(sValue.replace(sReplace, ""), sMaxDecimal)) return false;

    aryDecimal = sValue.split(".");
    aryValue = aryDecimal[0].split(",");

    if (aryValue.length == 1 && isDecimalPoint(aryValue[0],sMaxDecimal) && !(aryValue[0] >= 1000 || aryValue[0] <= -1000))
        return false;

    // Check the first part of the string value
    // the valid range is from -999 to 999
    if (aryValue[0].length <= 0 || aryValue[0].length > 3 || !isInteger(aryValue[0]) || aryValue[0] > 999 || aryValue[0] < -999 )
        return false;

    // check for the part other first part of string values
    // the valid range is from 000 to 999
    for (var i = 1; i < aryValue.length; i++)
        {
        if (isEmptyString(aryValue[i])) return false;
        if (aryValue[i].length != 3 || !isInteger(aryValue[i]) || aryValue[i] < 0 || aryValue[i] > 999)
            return false;
        }
    
    return true;
    }


function CurrencyToNumeric(sValue)
// Convert the currency pattern value to decimal value 货币转换成数字
// return STRING of Decimal value if valid currency or return Decimal value if valid decimal, 
// otherwise return empty string.
    {
    var sReplace = /,/gi;
    var sDecimalValue = new String;

    if (isCurrency(sValue)) sDecimalValue = sValue.replace(sReplace, "");
    if (isDecimalPoint(sValue, sMaxDecimal)) sDecimalValue = sValue;

    do
        {    
        if (sDecimalValue.substr(0,1) == "0")
            {
            sDecimalValue = sDecimalValue.substr(1, sDecimalValue.length - 1);
            bCheck = true;
            }
        else
            bCheck = false;
        }
    while (bCheck);

    return sDecimalValue;
    }
    
    
function containNumber(sValue) 
    {
// Check whether the string contains any Numeric character  是否为数字类型
// return TRUE if contains, otherwise return FALSE.
    var sElement = String(sValue);
    var sSubstring;
    
    if ( isEmptyString(sValue) ) return false;
    
    for (var i = 0; i < sElement.length; i++)    
        {
        sSubstring = sElement.substring(i, i+1);
        if (sInteger.indexOf(sSubstring) >= 0) return true;
        }
        
    return false;
    }

    
function changeDate(sDate)
// Split the date value into three parts for process 分隔日期年月日成数组
// return ARRAY if success, or EMPTY ARRAY if not
    {
    var aryDate = sDate.split(sDateSep);
    
    if (sDate.length < 8 || aryDate.length != 3)
        { 
        for (var i = 0; i < aryDate.length; i++) aryDate[i] = "";
        }

    return aryDate;
    }


function isLeapYear(iYear) 
    {
// Check whether the value is Leap Year 是否为闰年
// return TRUE if Leap Year, otherwise return FALSE.
    var bLeap = false;
    
    if (isEmptyString(iYear) || iYear <= 0) return false;
    
    if ((iYear % 4) == 0)   bLeap = true;
    if ((iYear % 100) == 0) bLeap = false;
    if((iYear % 400) == 0)  bLeap = true;
        
    return bLeap;
    }
    
function isMonthDay(sDate)
{
	 var aryDate = sDate.split(sDateSep);
	 var bValid = false;
	 if (aryDate.length != 2) return false;
	
	  if ((aryDate[iDateMonth].length != 2 ||!isInteger(aryDate[iDateMonth])) || (aryDate[iDateDay].length != 2 || !isInteger(aryDate[iDateDay])))
	    return false;
	   
	 if(aryDate[0] == 1 && aryDate[1] <= 31 && aryDate[iDateDay] > 0) bValid = true;
	
    if(aryDate[iDateMonth] == 2) 
        {
        var bLeapYear = isLeapYear('2005');
        if(bLeapYear  && aryDate[iDateDay]<=29 && aryDate[iDateDay] > 0) bValid = true;
        if(!bLeapYear && aryDate[iDateDay]<=28 && aryDate[iDateDay] > 0) bValid = true;
        }
    if(aryDate[iDateMonth] == 3  && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 4  && aryDate[iDateDay] <= 30 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 5  && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 6  && aryDate[iDateDay] <= 30 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 7  && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 8  && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 9  && aryDate[iDateDay] <= 30 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 10 && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 11 && aryDate[iDateDay] <= 30 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 12 && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;

    return bValid;   
}    
function isBeginEndTime(begin,end)
{
	if(!isTime(begin))return false;
	if(!isTime(end)) return false;
	
	var aryTimeBegin = changeTime( begin );  
	var aryTimeEnd	= changeTime( end ); 
	
	if(parseInt(aryTimeBegin[0]*60+aryTimeBegin[1])<=parseInt(aryTimeEnd[0]*60+aryTimeEnd[1]))
	{
	  
	   return true;
	}
	
	return false;
	 	
}

function isDate(sDate)   
//是否为日前
    {
// Check whether the string is a valid date value
// return TRUE if is valid date, otherwise return FALSE.
    var bValid = false;
    var aryDate = changeDate( sDate );    
    
    if (aryDate.length != 3) return false;
    if ((aryDate[iDateYear].length != 4 || !isInteger(aryDate[iDateYear])) || (aryDate[iDateMonth].length != 2 ||!isInteger(aryDate[iDateMonth])) || (aryDate[iDateDay].length != 2 || !isInteger(aryDate[iDateDay])))
        return false;
        
        
    
    if(aryDate[iDateMonth] == 1 && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 2) 
        {
        var bLeapYear = isLeapYear(aryDate[iDateYear]);
        if(bLeapYear  && aryDate[iDateDay]<=29 && aryDate[iDateDay] > 0) bValid = true;
        if(!bLeapYear && aryDate[iDateDay]<=28 && aryDate[iDateDay] > 0) bValid = true;
        }
    if(aryDate[iDateMonth] == 3  && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 4  && aryDate[iDateDay] <= 30 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 5  && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 6  && aryDate[iDateDay] <= 30 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 7  && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 8  && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 9  && aryDate[iDateDay] <= 30 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 10 && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 11 && aryDate[iDateDay] <= 30 && aryDate[iDateDay] > 0) bValid = true;
    if(aryDate[iDateMonth] == 12 && aryDate[iDateDay] <= 31 && aryDate[iDateDay] > 0) bValid = true;

    return bValid;    
    }

    
function isFutureDate(sDate)  
//是否为未来的日前
// Check whether the value is the today or date after today
// return TRUE if it is future, or return FALSE.
    {
    var aryDate = changeDate( sDate );    
    
    var dtDate  = new Date(aryDate[iDateYear], aryDate[iDateMonth]-1, aryDate[iDateDay]);
    var dtToday = new Date();
    
    if (((dtDate - dtToday)/(1000*60*60*24)) >= 0)
        return true;
    else
        return false;
    }
    

function isValidDateRange(sDateFrom, sDateTo) 
// Check whether the value of two dates is in a correct range, that is 1st Date is on or before 2nd Date
// return TRUE if valid, otherwise return FALSE
    {
    if (!isDate(sDateFrom)) return false;
    if (!isDate(sDateTo))   return false;

    var aryDate = changeDate( sDateFrom );    
    var dtFrom = new Date( aryDate[iDateYear], aryDate[iDateMonth]-1, aryDate[iDateDay] );
    var aryDate = changeDate( sDateTo );    
    var dtTo   = new Date( aryDate[iDateYear], aryDate[iDateMonth]-1, aryDate[iDateDay] );

    if ((dtTo - dtFrom) >= 0) 
        return true;
    else 
        return false;
    
    }
 
function isValidDateTimeRange(sDateFrom, sTimeFrom, sDateTo, sTimeTo) 
// Check whether the value of two datetime is in a correct range, that is 1st DateTime is on or before 2nd DateTime
// return TRUE if valid, otherwise return FALSE
    {
    var aryTimeFrom
    var aryTimeTo
    var bValidDateRange
    
    bValidDateRange = isValidDateRange(sDateFrom, sDateTo)

    if (!isTime(sTimeFrom)) 
        { return false; }

    if (!isTime(sTimeTo)) 
        { return false; }

    aryTimeFrom = sTimeFrom.split(sTimeSep);
    if (isEmptyString(aryTimeFrom[2]))
        {aryTimeFrom[2] = 0 ;}

    aryTimeTo    = sTimeTo.split(sTimeSep);
    if (isEmptyString(aryTimeTo[2]))
        {aryTimeTo[2] = 0 ;}

    if ( !bValidDateRange && (aryTimeTo[0] - aryTimeFrom[0]) >= 0 ) return false;
    if ( !bValidDateRange && (aryTimeTo[1] - aryTimeFrom[1]) >= 0 ) return false;
    if ( !bValidDateRange && (aryTimeTo[2] - aryTimeFrom[2]) >= 0 ) return false;
    
    return true ;

    }


function changeTime(sTime)  
//分隔时间时分秒
// Split the time value into three parts for process, return ARRAY
    {
    var aryTime = sTime.split(sTimeSep);
    
    if (isEmptyString(aryTime[2]))
        {aryTime[2] = 00 ;}

    return aryTime;
    }

function isTime(sTime)  
    {
// Check whether the string is a valid time value 是否为正确的时间
// return TRUE if is valid time, otherwise return FALSE.

    var aryTime = changeTime( sTime );    
   
    if (!(aryTime[0] >= 0 && aryTime[0] <= 23 ) || (isEmptyString(aryTime[0]))) return false;
   
    if (!(aryTime[1] >= 0 && aryTime[1] <= 59 ) || (isEmptyString(aryTime[1]))) return false;
   
    if (!(aryTime[2] >= 0 && aryTime[2] <= 59 )) return false;
	
    return true;
    }
  
    
function isHKID(sString) 
// check whether the string is a valid HKID  是否为16进制串
// return TRUE if valid, otherwise return FALSE
    {
    var sPrefixPattern = String(sAlphabet);
    var sDigitPattern  = String(sInteger);
    var sCheckPattern  = String(sInteger) + "A";
    var sIDValue = String("");

    if ((sString.length != 8) && (sString.length != 9)) return false;
            
    for (var i = 0; i <= sString.length - 8; i++)
        {
        sSubstring = sString.charAt(i).toUpperCase();
        if (sPrefixPattern.indexOf(sSubstring) == -1) return false;
        }

    for (var j = i; j < sString.length - 1; j++)
        {
        sSubstring = sString.charAt(i);
        if (sDigitPattern.indexOf(sSubstring) == -1) return false;
        }

    sSubstring = sString.charAt(j).toUpperCase();
    if (sCheckPattern.indexOf(sSubstring) == -1) return false;

    sIDValue = sString.substr(0,sString.length-1) + "(" + sString.substr(sString.length-1, sString.length) + ")"

    var iPos1 = sIDValue.indexOf("(");
    var iPos2 = sIDValue.indexOf(")");
    if (iPos1 < 7 || iPos1 > 8 || iPos1 != (iPos2 - 2) || sIDValue.length != (iPos2 + 1)) 
        return false;
    else 
        { 
        var id = " " + sIDValue.toLowerCase();
        sIDValue = id.substr(iPos1-7,10);
        var iCheckSum = 0;
        for (var i = 0; i < 8; i++)
            {
            var iCheckDigit = sIDValue.charCodeAt(i);
            if (iCheckDigit == 32) 
                iCheckSum += 36 * (9 - i);
            else if (iCheckDigit > 32 && iCheckDigit < 58) 
                iCheckSum += (iCheckDigit - 48) * (9 - i);
            else 
                iCheckSum += (iCheckDigit - 87) * (9 - i);
            }
        iCheckDigit = iCheckSum % 11;
        if (iCheckDigit != 0)  iCheckDigit = (11 - iCheckDigit);
        if (iCheckDigit == 10) iCheckDigit = "A";

        if (String(sIDValue.charAt(9).toUpperCase()) != String(iCheckDigit)) return false;
        }

    return true; 
    }    

function isNumeric(sValue , iLen , iDecLen)  
	{
// Check for validility of Numeric value (including integer)
// Field numeric(iLen,iDecLen)
// return TRUE if integer, otherwise return FALSE.
	var sInValue = String(sValue);
	var aryValue;
	var iDot = 0;
	var bDecimal = true;
	var iMinus = 0;
	var iIntLen = iLen - iDecLen
	
	if (isEmptyString(sInValue))
		{ return false; }
	
	if (sInValue.indexOf(sSpace) >= 0)
		{ return false; }
	
	iMinus = sInValue.indexOf("-");
	if (iMinus >= 0)
		{ return false; }
	
	aryValue = sInValue.split(".");
	if (aryValue.length > 2 || aryValue.length <= 0)
		{ return false ; }
	for (var i = 0; i < aryValue.length; i++)
		{
		if (isEmptyString(aryValue[i]))
			{ iDot++; }
		else if (aryValue[i].length > 0)
			{
			if (i == 0)
				{
				 bDecimal = isInteger(aryValue[i]); 
				 bDecimal = bDecimal && aryValue[i].length >= 0 && aryValue[i].length <= iIntLen ; 
				}
			else
				{ 
				 bDecimal = isInteger(aryValue[i]); 
				 if (iDecLen==0)
					bDecimal = bDecimal && aryValue[i].length==0 ;
				 }
			}
			
		if (iDot > 1 || !bDecimal)
			{ return false; }
		}
		
	return true;
	}

function isRational(sValue , iLen , iDecLen)
	{
// Check for validility of Rational Numeric value (including integer , Negative)
// Field numeric(iLen,iDecLen)
// return TRUE if integer, otherwise return FALSE.
	var sInValue = String(sValue);
	var aryValue;
	var iDot = 0;
	var bDecimal = true;
	var iMinus = 0;
	var iIntLen = iLen - iDecLen
	
	if (isEmptyString(sInValue))
		{ return false; }
	
	if (sInValue.indexOf(sSpace) >= 0)
		{ return false; }
	
	iMinus = sInValue.indexOf("-");
	if (iMinus > 0)
		{ return false; }
	else if (iMinus == 0)
		{ sInValue = sInValue.substr(1, sInValue.length-1); }
	
	aryValue = sInValue.split(".");
	if (aryValue.length > 2 || aryValue.length <= 0)
		{ return false ; }
	for (var i = 0; i < aryValue.length; i++)
		{
		if (isEmptyString(aryValue[i]))
			{ iDot++; }
		else if (aryValue[i].length > 0)
			{
			if (i == 0)
				{
				 bDecimal = isInteger(aryValue[i]); 
				 bDecimal = bDecimal && aryValue[i].length >= 0 && aryValue[i].length <= iIntLen ; 
				}
			else
				{ 
				 bDecimal = isInteger(aryValue[i]); 
				 if (iDecLen==0)
					bDecimal = bDecimal && aryValue[i].length==0 ;
				 }
			}
			
		if (iDot > 1 || !bDecimal)
			{ return false; }
		}
		
	return true;
	}

function isAlphaNumericSpace(sString) 
// Check whether the string contains alphanumeric character only.
// return TRUE if only AlphaNumeric, otherwise return FALSE.
    {
    var sAllowChar = String(sAlphabet) + String(sInteger) + String(sSpace);    
    return isValidString(sString, sAllowChar);
    }    


function isNumericSpecial(sString)
	{
// Check whether the string contains any invalid character (non alphanumeric, "-", "_" ...)
// return TRUE if is valid string, otherwise return FALSE.
	var sAllowChar = String(sInteger) + String(sSpecial);
	return isValidString(sString, sAllowChar);
	}
	
function AddDay(sDate,AddType,AddNum)
//  日期增加，增加年月日
  {
  var FormDate;
  var FormTimes;
  var aryDate = changeDate( sDate );
  var sStr;
          
      sDate=aryDate[1]+"/"+aryDate[0]+"/"+aryDate[2];
      FormDate= new Date(sDate);
      if( AddType == "D" || AddType=="d" )
        {  FormTimes=FormDate.getTime()+(AddNum*24*60*60*1000)
          FormDate.setTime(FormTimes); }     
          
      sStr="";
      if(FormDate.getDate()<10)
        sStr="0"+FormDate.getDate();
      else
        sStr=FormDate.getDate();
        
      if((FormDate.getMonth()+1)<10)
        sStr=sStr+"/"+"0"+(FormDate.getMonth()+1);
      else
        sStr=sStr+"/"+(FormDate.getMonth()+1);
        
      sStr=sStr+"/"+(FormDate.getFullYear());        
                 
  return  sStr;
  }
  
function Round(Number , DecLen)
//四舍五入
{
	return Math.round(Number*Math.pow(10,DecLen))/Math.pow(10,DecLen);
}

function RoundNumeric( Numeric,iDot )
//从第小数idot位四舍五入
  {  var sNumeric;
     var aryValue;
     var i;
     var flag;
     var tempInt;
     var tempStr="";
     sNumeric=String( Numeric );
      if (isPositive(sNumeric))
      { 
        aryValue = sNumeric.split( "." );
        if ( aryValue.length == 2 )
          {      
             if( aryValue[1].length<iDot)
               return sNumeric; 
             tempInt=parseInt( aryValue[1].substring( iDot,iDot+1 ) );
               if ( tempInt > 4 )
                   flag=true;
               else 
                   flag=false;
             i=iDot-1;
           for ( ;i >= 0;i-- ) 
               {  
               tempInt=parseInt( aryValue[1].substring( i,i+1 ) );
                  if (flag)
                    {  tempInt=tempInt+1;
                       if (tempInt==10) 
                          {  flag=true;
                             if ( tempStr!="" ) 
                             tempStr="0"+tempStr; }
                       else
                          {  flag=false;
                             if ( tempStr!="" || tempInt!=0 )
                             tempStr=String( tempInt )+tempStr; }
                    }
                   else
                     {
                       flag=false;
                        if ( tempStr!="" || tempInt!=0 )
                       tempStr=String( tempInt )+tempStr; }
                } 
                if( tempStr!="" )
                    tempStr="."+tempStr;    
                i=aryValue[0].length-1;
             for (; i>=0 ; i-- )
                 {tempInt=parseInt( aryValue[0].substring( i,i+1 ) );
                  if (flag)
                      { tempInt=tempInt+1;
                        if (tempInt==10)
                             { flag=true;
                               tempStr="0"+tempStr; }
                        else
                             { flag=false;
                               tempStr=String(tempInt)+tempStr; }

                       }
                   else
                       {  
                          flag=false;
                          tempStr=String(tempInt)+tempStr; }
                  }

                 if (flag)
                    tempStr="1"+tempStr;
            }
        else  return sNumeric;          
      }      
    else 
     {  
        sNumeric=String( Math.abs(Numeric) );
        aryValue = sNumeric.split( "." );
        if ( aryValue.length == 2 )
          { 
             if( aryValue[1].length<iDot)
               return "-"+sNumeric; 
             tempInt=parseInt( aryValue[1].substring( iDot,iDot+1 ) );
               if ( tempInt > 5 )
                   flag=true;
               else 
                   flag=false;
             i=iDot-1;
           for ( ;i >= 0;i-- ) 
               {  
               tempInt=parseInt( aryValue[1].substring( i,i+1 ) );
                  if (flag)
                    {  tempInt=tempInt+1;
                       if (tempInt==10) 
                          {  flag=true;
                             if ( tempStr!="" ) 
                             tempStr="0"+tempStr; }
                       else
                          {  flag=false;
                             if ( tempStr!="" || tempInt!=0 )
                             tempStr=String( tempInt )+tempStr; }
                    }
                   else
                     {
                       flag=false;
                       if ( tempStr!="" || tempInt!=0 )
                       tempStr=String( tempInt )+tempStr; }
                } 
                if (tempStr!="")
                    tempStr="."+tempStr;        
                i=aryValue[0].length-1;
             for (; i>=0 ; i-- )
                 {  tempInt=parseInt( aryValue[0].substring( i,i+1 ) );
                  if (flag)
                      { tempInt=tempInt+1;
                        if (tempInt==10)
                             { flag=true;
                               tempStr="0"+tempStr; }
                        else
                             { flag=false;
                               tempStr=String(tempInt)+tempStr; }

                       }
                   else
                       {  
                          flag=false;
                          tempStr=String(tempInt)+tempStr; }
                  }

                 if (flag)
                    tempStr="1"+tempStr;
                 if(tempStr=="0")
                    return tempStr;   
                 tempStr="-"+tempStr;   
            }
          else  return "-"+sNumeric;    
      }             
            return tempStr;
   }
   
function isPositive(sValue)
// Check for validility of Positive Integer
// return TRUE if Positive integer, otherwise return FALSE.
    {
    if (sValue.indexOf ("-") >= 0) 
		return false;
    else 
		return true;
    }
    
function isPrdToPst(sValue)
//是否为年月yyyy-mm类型
	{
	var sLen=sValue.length;
	if (sLen!=7)
		return false;

	if (sValue.substring(4,5)!="/")
		return false;
		
	if (! isInteger(sValue.substring(0,4)))
		return false;
		
	if (! isInteger(sValue.substring(5,7)))
		return false;
		
	if (parseFloat(sValue.substring(5,7)) < 1 || parseFloat(sValue.substring(5,7)) > 12)
		return false;
	
	return true;
	}

function isExistQuotation(sValue)
//判断是否有双引号和单引号
{
	if (sValue.indexOf('"')!=-1)
		return true;
	if (sValue.indexOf("'")!=-1)
		return true;
	return false;
}

function isValidIdentifier(sValue)
{

	if(!isAlphabet(sValue.substr(0,1))&&sValue.substr(0,1)!="_")
	return false;
	
	for(var i = 1; i < sValue.length; i++)
	{
		if(!isAlphabet(sValue.substr(i,1))&&!isInteger(sValue.substr(i,1))&&sValue.substr(i,1)!="_")	
		return false;
	}
	
	return true;
}

function selectByValue(obj, value)
{	// check for match in _options array
	for (var i=0; i < obj.options.length; i++)
	{
		if (value == obj.options[i].value)
		{
			obj.selectedIndex = i;
			return i;
		}
	}
	return -1;
}

function selectByText(obj, value)
{	// check for match in _options array
	for (var i=0; i < obj.options.length; i++)
	{
		if (value == obj.options[i].text.replace("\\",""))
		{
			obj.selectedIndex = i;
			return i;
		}
	}
	return -1;
}


function getDate(objDate){
        var newDate 
        newDate=window.showModalDialog("../../system/Calender.htm","","status:no;center:yes;help:no;minimize:no;maximize:no;dialogWidth:330px;dialogHeight:320px")
        if (newDate=="")
           return
        objDate.value = newDate
    }
    
  
 



