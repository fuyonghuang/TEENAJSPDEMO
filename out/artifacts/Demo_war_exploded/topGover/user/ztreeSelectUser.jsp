<%--
  Created by IntelliJ IDEA.
  User: fuyong_huang
  Date: 2018/1/11
  Time: 9:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/css/demo.css" type="text/css">
    <link rel="stylesheet" href="/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="/js/ztree/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="/js/ztree/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="/js/ztree/jquery.ztree.excheck.js"></script>
</head>
<body>
<div class="content_wrap">
    <div class="zTreeDemoBackground left">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
</div>
</body>

<script>

  /*  $.ajaxSetup({
      async: false
    });*/
  var setting = {
    view: {
      selectedMulti: false
    },
    check: {
      enable: true
    },
    data: {
      simpleData: {
        enable: true
      }
    },
    callback: {
      beforeCheck: beforeCheck,
      onCheck: onCheck
    }
  };

  var zNodes;
  $(function () {
    $.get("/topGover/user/userInfo.json", function (result) {
      zNodes = result;
      init();

    });
  })
  var code, log, className = "dark";

  function beforeCheck(treeId, treeNode) {
    className = (className === "dark" ? "" : "dark");
    showLog("[ " + getTime() + " beforeCheck ]&nbsp;&nbsp;&nbsp;&nbsp;" + treeNode.name);
    return (treeNode.doCheck !== false);
  }

  function onCheck(e, treeId, treeNode) {
    showLog("[ " + getTime() + " onCheck ]&nbsp;&nbsp;&nbsp;&nbsp;" + treeNode.name);
  }

  function showLog(str) {
    if (!log) log = $("#log");
    log.append("<li class='" + className + "'>" + str + "</li>");
    if (log.children("li").length > 6) {
      log.get(0).removeChild(log.children("li")[0]);
    }
  }

  function getTime() {
    var now = new Date(),
        h = now.getHours(),
        m = now.getMinutes(),
        s = now.getSeconds(),
        ms = now.getMilliseconds();
    return (h + ":" + m + ":" + s + " " + ms);
  }

  function checkNode(e) {
    var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
        type = e.data.type,
        nodes = zTree.getSelectedNodes();
    if (type.indexOf("All") < 0 && nodes.length == 0) {
      alert("请先选择一个节点");
    }

    if (type == "checkAllTrue") {
      zTree.checkAllNodes(true);
    } else if (type == "checkAllFalse") {
      zTree.checkAllNodes(false);
    } else {
      var callbackFlag = $("#callbackTrigger").attr("checked");
      for (var i = 0, l = nodes.length; i < l; i++) {
        if (type == "checkTrue") {
          zTree.checkNode(nodes[i], true, false, callbackFlag);
        } else if (type == "checkFalse") {
          zTree.checkNode(nodes[i], false, false, callbackFlag);
        } else if (type == "toggle") {
          zTree.checkNode(nodes[i], null, false, callbackFlag);
        } else if (type == "checkTruePS") {
          zTree.checkNode(nodes[i], true, true, callbackFlag);
        } else if (type == "checkFalsePS") {
          zTree.checkNode(nodes[i], false, true, callbackFlag);
        } else if (type == "togglePS") {
          zTree.checkNode(nodes[i], null, true, callbackFlag);
        }
      }
    }
  }

  function setAutoTrigger(e) {
    var zTree = $.fn.zTree.getZTreeObj("treeDemo");
    zTree.setting.check.autoCheckTrigger = $("#autoCallbackTrigger").attr("checked");
    $("#autoCheckTriggerValue").html(zTree.setting.check.autoCheckTrigger ? "true" : "false");
  }

  function init() {
    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
    $("#checkTrue").bind("click", {type: "checkTrue"}, checkNode);
    $("#checkFalse").bind("click", {type: "checkFalse"}, checkNode);
    $("#toggle").bind("click", {type: "toggle"}, checkNode);
    $("#checkTruePS").bind("click", {type: "checkTruePS"}, checkNode);
    $("#checkFalsePS").bind("click", {type: "checkFalsePS"}, checkNode);
    $("#togglePS").bind("click", {type: "togglePS"}, checkNode);
    $("#checkAllTrue").bind("click", {type: "checkAllTrue"}, checkNode);
    $("#checkAllFalse").bind("click", {type: "checkAllFalse"}, checkNode);

    $("#autoCallbackTrigger").bind("change", {}, setAutoTrigger);
  }


</script>
</html>
