/**
 * 名称：湖南CA--NetONE系统集成（标准）
 * 版本：3.3.0
 * 更新时间：2017.07.28
 * 维护人员：Akay
 *
 * 更新日志：
 * ver3.5 2017.08.22
 *     1. 修正部分不兼容的地方，会导致浏览器报错。
 *     2. 强类型转化，防止参数错误。
 *     3. 去除签名是获取证书信息。
 *
 * ver3.4 2017.08.08
 *     1. 获取证书使用者G项
 *     2. 获取颁发者O项目
 *     3. 改进获取证书信息的方式
 * ver3.3 2017.07.28
 *     1. 新增获取证书更多信息,如：内容，SN，附加信息，失效时间等等。
 *     2. 证书进行签名操作时也会更新读取证书信息
 *
 * ver3.2 2017.07.25
 *     1. 修复返回错误不正常的地方
 *
 * ver3.1 2017.07.17
 *     1. 新增方法：HuncaSHA1()对数据做SHA-1摘要操作。
 *     2. 控件加载如果不成功给予错误提示。
 *
 * ver3.0
 *     1. 搭建好基本架构使得控件加载支持IE，Chrome 45以下，Firefox 52以下。（支持ActiveX标准或NP_AIP标准的浏览器）
 *     2. 新增HuncaGetLastError()，SelectCert(),VerifyPIN(),PKCS1String()等方法，支持密码验证，证书选择，数据签名等基本功能。
 *     3. 新增方法：HuncaGetSign(),HuncaGetCert() 签名成功后获取 签名结果 与 签名证书
 *
 * ver 2.0
 *      1. 采用面向对象的接口提供方式，增强接口的独立性，方便开发人员更易于集成。
 *        使用方法：var activex = new HUNCA_NETONEX_CORE();
 *      2. 补齐: 基本方法,方便开发人员集成，输入密码有两种方式：
 *         >开发人员自定义密码框。
 *         >采用组件或Ukey厂家密码输入框。
 *      3. 支持散列算法：sha-1
 *      4. 支持字符串做P1裸签。
 *
 * ver 1.0
 *     1.由于依赖文件过于老旧，许多新增方法无法使用，顾放弃。
 *
 *
 * ------------
 * 基本调用方法：
 * ------------
 *     类似于面向对象的调用方式：
 *          var activex = new HUNCA_NETONEX_CORE()
 *     调用完成后集成调用内部的相关方法，如使用证书签名:
 *          activex.HuncaPKCS1(data,userPin);
 *     如果调用成功则可以调用以下方法获取签名证书与签名结果
 *          activex.HuncaGetSign();
 *          activex.HuncaGetCert();
 *
 * ----------------
 * 关于私有与共有方法：
 * ----------------
 *   共有方法（可以调用）---> 格式：this.xxx = function(){}
 *   私有方法（不可调用）---> 格式：function xxx(){}
 *   私有变量（不可调用）---> 格式：var xxx;
 *
 * @constructor
 */

function HUNCA_NETONEX_CORE() {

    var ca_cert = null;
    var ca_sign = null;
    var ca_data = null;

    var lastError = "";

    var ca_sn = "";
    var ca_OID2541 = "";
    var ca_content = "";
    var ca_NotAfterSystemTime = "";

    var ca_subject_G = "";
    var ca_issuer_O = "";

    try {
        var netONEX = new NetONEX();
        netONEX.setupObject();
        var cmainx = netONEX.getMainX();
        var ccx = netONEX.getCertificateCollectionX();
        var cx = null;
        var cbase64x = netONEX.getBase64X();
        var chashx = netONEX.getHashX();
    } catch (e) {
        alert("CA安全控件加载失败，请确保计算机安装最新驱动！");
        return null;
    }

    this.HuncaGetLastError = function () {
        return lastError;
    };


    /**
     * 对数据进行SHA-1操作，返回
     * @param data
     * @returns {*}
     * @constructor
     */
    this.HuncaSHA1 = function (data) {
        var resData = null;
        var dataBytes = null;

        chashx.Quiet = 1;
        if (data.length == 0) {
            lastError = "数据不能为空!";
            return "";
        }

        dataBytes = cbase64x.DecodeBytes(cbase64x.EncodeUtf8String(data));
        resData = chashx.SHA1String(dataBytes);

        if (resData == "") {
            lastError = chashx.ErrorString;
        }

        return resData;
    };


    /**
     * 获取计算机证书库中的证书，如果符合要求的证书有多张则弹出证书选择框。
     * @returns {boolean}
     * @constructor
     */
    function SelectCert() {
    	if(cx == null){
	        var certMax = 0;
	        ccx.CF_KeyUsage = 0x20;
	        ccx.CF_Issuer_Contains = "湖南";
	        ccx.OEM = 2;
	        ccx.Quiet = 1;
	        certMax = ccx.Load();
	
	        if (certMax < 1) {
	            lastError = "对不起，未能获取到数字证书！";
	            return false;
	        }
	        else if (certMax == 1) {
	            cx = ccx.GetAt(0);
	        }
	        else {
	            cx = ccx.SelectCertificateDialog();
	            if (cx == null) {
	                cx = null;
	                lastError = "用户取消证书选择！";
	                return false;
	            }
	        }
    	}
        return true;
    };

    /**
     * 验证证书对应的Ukey密码
     * @param userPin 传入Ukey的密码
     * @returns {boolean} true，表示密码验证成功;false，密码验证失败。可以通过lastError获取剩余次数
     * @constructor
     */
    function VerifyPIN(userPin) {
        var res = 0;
        var algo = null;
        var m_Pin = "";

        m_Pin = "" + userPin;
        if (m_Pin.length < 4 || m_Pin.length > 16) {
            lastError = "Ukey密码必须为4~16位,请重新输入！";
            return false;
        }

        cx.Quiet = 1;
        res = cx.VerifyPIN(m_Pin);  //验证密码是否正确
        algo = cx.Algorithm;    //获取算法

        if (algo == "RSA" && res == -1) {
            lastError = "UKey密码不正确，请输入正确的密码！\n可使用客户端\"验证密码\"功能获取Ukey剩余次数！";
            return false;
        }

        if (algo != "RSA" && res == -1) {
            lastError = "UKey密码已经被锁死，请联系管理员进行解锁操作!";
            return false;
        }

        if (algo != "RSA" && res > 0) {
            lastError = "UKey密码不正确，请输入正确的密码,还剩" + res + "次重试机会!";
            return false;
        }

        cx.UserPIN = m_Pin;   //最后将密码置于预设密码处
        return true;
    };

    /**
     * 对数据做签名操作。
     * @param data
     * @returns {boolean}
     * @constructor
     */
    function PKCS1String(data) {
        var result = null;
        var m_data = "";

        ca_cert = null;
        ca_data = null;
        ca_sign = null;

        m_data = "" + data;

        if (m_data == null || m_data.Length == 0) {
            lastError = "签名原文不能为空！";
            return false;
        }

        if (cx == null) {
            lastError = "证书对象不能为空，请插入UKey！";
            return false;
        }

        cx.Quiet = 1;
        reslut = cx.PKCS1String(m_data);
        if (reslut == null || reslut == "") {
            lastError = cx.ErrorString;
            return false;
        }


        ca_cert = cx.Content;
        ca_sign = reslut;
        ca_data = m_data;

        return true;
    };

    /**
     * 对data数据做签名
     * @param data 待签名原始数据
     * @param userPin   Ukey的密码。如果为 userPin 为 null，则弹出控件自定义密码框
     * @returns {boolean}  true，表示签名成功；false，表示签名失败
     * @constructor
     */
    this.HuncaPKCS1Ex = function (data, userPin) {
        lastError = "";
        ca_cert = null;
        ca_data = null;
        ca_sign = null;

        if (!SelectCert()) {
            return false;
        }

        var version = cmainx.Version;
        if (parseInt(version) > 16974848 && userPin != null) {
            if (!VerifyPIN(userPin)) {
                return false;
            }
        }

        if (!PKCS1String(data)) {
            return false;
        }

        return true;
    };

    /**
     * 对data数据做签名，调用控件自身的密码输入框。
     * @param data  待签名数据
     * @returns {boolean}   true，表示签名成功，false，表示签名失败。
     * @constructor
     */
    this.HuncaPKCS1 = function (data) {
        return this.HuncaPKCS1Ex(data, null);
    };


    /**
     * 对data数据做签名，同HuncaPKCS1方法
     * @param data  待签名原始数据
     * @returns {boolean}   true，表示签名成功；false，表示签名失败
     * @constructor
     */
    this.HuncaLogin = function (data) {
        lastError = "";
        return this.HuncaPKCS1(data);
    };

    /**
     * 对data数据做签名，同HuncaPKCS1方法
     * @param data  待签名原始数据
     * @param userPin   Ukey的密码
     * @returns {boolean}   true，表示签名成功；false，表示签名失败
     * @constructor
     */
    this.HuncaLoginEx = function (data, userPin) {
        lastError = "";
        return this.HuncaPKCS1Ex(data, userPin);
    };

    /**
     * 如果签名成功返回 签名结果
     * @returns {*}
     * @constructor
     */
    this.HuncaGetSign = function () {
        return ca_sign;
    };

    /**
     * 如果签名成功返回 签名证书
     * @returns {*}
     * @constructor
     */
    this.HuncaGetCert = function () {
        return ca_cert;
    };

    /**
     * 获取证书信息
     * @returns {boolean}
     * @constructor
     */
    this.HuncaGetCertInfo = function () {
        if (!SelectCert()) {
            return false;
        }

        return GetCertInfo();
    };

    /**
     * 获取证书信息
     * @returns {boolean}
     * @constructor
     */
    function GetCertInfo() {
        ca_content = "";
        ca_sn = "";
        ca_NotAfterSystemTime = "";
        ca_OID2541 = "";

        ca_content = cx.Content;
        ca_sn = cx.SerialNumberDec;
        ca_NotAfterSystemTime = cx.NotAfterSystemTime;


        ca_OID2541 = DealString(cx.Subject, "OID.2.5.4.1");     //处理OID2.5.4.1
        ca_subject_G = DealString(cx.Subject, "G");  //处理使用者G项
        ca_issuer_O = DealString(cx.Issuer, "O");    //处理颁发者O项
        return true;
    }

    /**
     * 获取证书内容
     * @returns {string}
     * @constructor
     */
    this.HuncaGetContent = function () {
        return ca_content;
    };

    /**
     * 获取证书
     * @returns {string}
     * @constructor
     */
    this.HuncaGetSN = function () {
        return ca_sn;
    };

    /**
     * 获取证书失效时间
     * @returns {string}
     * @constructor
     */
    this.HuncaGetNotAfterSystemTime = function () {
        return ca_NotAfterSystemTime;
    };

    /**
     * 获取证书附加
     * @returns {string}
     * @constructor
     */
    this.HuncaGetOID2541 = function () {
        return ca_OID2541;
    };

    this.HuncaGetSubject_G = function () {
        return ca_subject_G;
    };

    this.HuncaGetIssure = function () {
        return ca_issuer_O;
    }

    function DealString(arg_str, arg_key) {
        var strList = null;
        var skey, svalue, slist;

        strList = arg_str.split(',');
        for (var i = 0; i < strList.length; i++) {
            slist = strList[i].split("=");
            skey = trimSpace(slist[0]);
            svalue = trimSpace(slist[1]);

            if (skey == arg_key) {
                return svalue;
            }
        }
        return "";
    }


    /**
     * 取出字符串两端空格
     * @param str
     * @returns {void|XML|string}
     */
    function trimSpace(str) { //删除左右两端的空格
        return str.replace(/(^\s*)|(\s*$)/g, "");
    }
}