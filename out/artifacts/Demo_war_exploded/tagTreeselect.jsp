<%@ page contentType="text/html;charset=UTF-8" %>
<%--<%@ include file="/WEB-INF/views/include/taglib.jsp"%>--%>
<%
    String checked = request.getParameter("checked") == null ? "" : request.getParameter("checked");
    String url = request.getParameter("url");
    String type = "2";
%>
<html>
<head>

    <title>数据选择</title>
    <meta name="decorator" content="blank"/>
    <link rel="stylesheet" href="/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="/js/ztree/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="/js/ztree/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="/js/ztree/jquery.ztree.excheck.js"></script>
    <script>
      debugger
      var key, lastValue = "", nodeList = [], type = "<%=type%>";
      var showRoleName = "";

      var userTreeDateUrl = "/topGover/office/office.json";
      var param = "id";
      if (type == '3') {
        userTreeDateUrl = "/topGover/office/office.json";
        param = ""
      }
      if (type == '2') {
        userTreeDateUrl = "/topGover/office/office.json"
      }
      var tree, setting = {
        view: {
          selectedMulti: false

        },
        check: {
          enable: true,
          nocheckInherit: true
        },
        async: {
          enable: true,
          url: userTreeDateUrl,
          autoParam: [param]
        },
        data: {
          simpleData: {
            enable: true
          }
        },
        callback: {
          onClick: function (event, treeId, treeNode) {
            tree.expandNode(treeNode);
          },
          onCheck: function (e, treeId, treeNode) {
            addLabel(treeNode);
            var nodes = tree.getCheckedNodes(true);
            for (var i = 0, l = nodes.length; i < l; i++) {
              tree.expandNode(nodes[i], true, false, false);
            }
            return false;
          },
          onAsyncSuccess: function (event, treeId, treeNode, msg) {
            var nodes = tree.getNodesByParam("pId", treeNode.id, null);
            for (var i = 0, l = nodes.length; i < l; i++) {
              try {
                tree.checkNode(nodes[i], treeNode.checked, true);
              } catch (e) {
              }
              //tree.selectNode(nodes[i], false);
            }
            selectCheckNode();
          },
          onDblClick: function () {//<% if(!"true".equals(checked)){
            %>

            top.$("div[role=dialog]").find("button[i-id=ok]").trigger("click");//
            <%
              }%>
          }
        }
      };

      function expandNodes(nodes) {
        if (!nodes)
          return;
        for (var i = 0, l = nodes.length; i < l; i++) {
          tree.expandNode(nodes[i], true, false, false);
          if (nodes[i].isParent && nodes[i].zAsync) {
            expandNodes(nodes[i].children);
          }
        }
      }

      $(function () {
        $.get("<%=url%>", function (zNodes) {
          // 初始化树结构
          debugger
          tree = $.fn.zTree.init($("#tree"), setting, zNodes);

          // 默认展开一级节点
          var nodes = tree.getNodesByParam("level", 0);
          for (var i = 0; i < nodes.length; i++) {
            tree.expandNode(nodes[i], true, false, false);
          }
          //异步加载子节点（加载用户）
//             var nodesOne = tree.getNodesByParam("isParent", true);
//             for (var j = 0; j < nodesOne.length; j++) {
//                 tree.reAsyncChildNodes(nodesOne[j], "!refresh", true);
//             }
          selectCheckNode();
        });
        key = $("#key");
        key.bind("focus", focusKey).bind("blur", blurKey).bind("change cut input propertychange",
            onKeyvalueChange);
        key.bind('keydown', function (e) {
          if (e.which == 13) {
            searchNode();
          }
        });
      });

      var keyvalueChangeTimeout;

      function onKeyvalueChange() {
        if (keyvalueChangeTimeout) {
          clearTimeout(keyvalueChangeTimeout);
        }
        keyvalueChangeTimeout = setTimeout("searchNode()", 1000);	// 延时1秒
      }

      // 默认选择节点
      function selectCheckNode() {
        var ids = "".split(",");
        for (var i = 0; i < ids.length; i++) {
          var node = tree.getNodeByParam("id", (type == 3 ? "u_" : "") + ids[i]);
          if ("<%=checked%>" == "true") {
            try {
              tree.checkNode(node, true, true);
            } catch (e) {
            }
            tree.selectNode(node, false);
          } else {
            tree.selectNode(node, true);
          }
          addLabel(node);
        }
      }

      function focusKey(e) {
        if (key.hasClass("empty")) {
          key.removeClass("empty");
        }
      }

      function blurKey(e) {
        if (key.get(0).value === "") {
          key.addClass("empty");
        }
        searchNode(e);
      }

      //搜索节点
      function searchNode() {
        if (keyvalueChangeTimeout) {
          clearTimeout(keyvalueChangeTimeout);
        }

        // 取得输入的关键字的值
        var value = $.trim(key.get(0).value);

        // 按名字查询
        var keyType = "name";

        if (lastValue === value) {
          return;
        }

        // 保存最后一次
        lastValue = value;

        var nodes = tree.getNodes();
        if (value == "") {
          showAllNode(nodes);
          return;
        }
        hideAllNode(nodes);
        nodeList = tree.getNodesByParamFuzzy(keyType, value);
        updateNodes(nodeList);
      }

      //搜索名字
      function searchName() {

        if (keyvalueChangeTimeout) {
          clearTimeout(keyvalueChangeTimeout);
        }

        // 取得输入的关键字的值
        var value = $.trim(key.get(0).value);

        $.get("<%=url%>", function (zNodes) {
          // 初始化树结构
          debugger
          tree = $.fn.zTree.init($("#tree"), setting, zNodes);
          if (value != null && value != "") {
            // 默认展开全部节点
            var nodes = tree.getNodesByParam("level", 0);
            for (var i = 0; i < nodes.length; i++) {
              tree.expandNode(nodes[i], true, true, false);
            }
          } else {
            // 默认展开一级节点
            var nodes = tree.getNodesByParam("level", 0);
            for (var i = 0; i < nodes.length; i++) {
              tree.expandNode(nodes[i], true, false, false);
            }
          }
          selectCheckNode();
        });
      }

      //隐藏所有节点
      function hideAllNode(nodes) {
        nodes = tree.transformToArray(nodes);
        for (var i = nodes.length - 1; i >= 0; i--) {
          tree.hideNode(nodes[i]);
        }
      }

      //显示所有节点
      function showAllNode(nodes) {
        nodes = tree.transformToArray(nodes);
        for (var i = nodes.length - 1; i >= 0; i--) {
          /* if(!nodes[i].isParent){
              tree.showNode(nodes[i]);
          }else{ */
          if (nodes[i].getParentNode() != null) {
            tree.expandNode(nodes[i], false, false, false, false);
          } else {
            tree.expandNode(nodes[i], true, true, false, false);
          }
          tree.showNode(nodes[i]);
          showAllNode(nodes[i].children);
          /* } */
        }
      }

      //更新节点状态
      function updateNodes(nodeList) {
        tree.showNodes(nodeList);
        for (var i = 0, l = nodeList.length; i < l; i++) {
          //显示子节点
          tree.showNodes(nodeList[i].children);

          //展开当前节点的父节点
          tree.showNode(nodeList[i].getParentNode());
          //tree.expandNode(nodeList[i].getParentNode(), true, false, false);
          //显示展开符合条件节点的父节点
          while (nodeList[i].getParentNode() != null) {
            tree.expandNode(nodeList[i].getParentNode(), true, false, false);
            nodeList[i] = nodeList[i].getParentNode();
            tree.showNode(nodeList[i].getParentNode());
          }
          //显示根节点
          tree.showNode(nodeList[i].getParentNode());
          //展开根节点
          tree.expandNode(nodeList[i].getParentNode(), true, false, false);
        }
      }

      // 右侧显示已选择的
      function addLabel(treeNode) {
        if (!treeNode) {
          return;
        }

        if (treeNode.isParent) {
          for (var i = 0; i < treeNode.children.length; i++) {
            var cnode = treeNode.children[i];
            addLabel(cnode);
          }
        } else {
          if (treeNode.getCheckStatus().checked) {
            if ($('#selectdiv #' + treeNode.id).length == 0) {
              $("#selectdiv").append("<label class='tag-label label-info' id='" + treeNode.id
                  + "' onclick='deleteLabel(this.id,1)'>" + treeNode.name + "</label>");
            }
          } else {
            deleteLabel(treeNode.id);
          }
        }
      }

      function deleteLabel(nodeid, uncheckflag) {
        $('#selectdiv #' + nodeid).remove();
        if (uncheckflag == 1) {
          var node = tree.getNodeByParam("id", nodeid);
          tree.checkNode(node, false, true);
          tree.cancelSelectedNode(node);
        }
      }
    </script>
    <style type="text/css">
        html, body {
            height: 100%;
            width: 100%;
        }

        .tag-label {
            /*             border: 1px solid #D0D0D0; */
            /*padding: 4px 7px;*/
            margin: 4px 4px;
            color: #fff;
            cursor: pointer;
            float: left;
            margin-bottom: 0px;
            margin-top: 0px;
            padding-top: 2px !important;
            padding-bottom: 5px !important;
            padding-left: 4px;
            padding-right: 4px;
        }

        .tag-label:hover {
            text-decoration: line-through;
        }

        .label-info {
            background-color: #5bc0de;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
<div style="height: 100%; padding: 40px 0 0; box-sizing: border-box;">
    <div id="search" class="input-group" style="margin: -40px 0 0;">
        <input id="key" name="key" type="text" class="form-control" maxlength="50"
               placeholder="请输入关键字">
        <a href="javascript:searchNode();"></a>
        <a href="javascript:searchName();" class="btn btn-default input-group-addon"> <i
                class="glyphicon glyphicon-search"></i></a>
    </div>
    <div style="height:100%;">
        <% if (checked.equals("true")) {
        %>
        <div id="tree" class="ztree" style="float:left;width:60%;height:100%;overflow: auto;">
            正在加载...
        </div>
        <div style="float:right;height:100%;width:40%;padding: 2px;overflow: auto;">已选择：<br/>
            <div id="selectdiv"></div>
        </div>
        <%
            }%>
        <% if (!checked.equals("true")) {
        %>
        <div id="tree" class="ztree" style="float:left;width:100%;height:100%;overflow: auto;">
            正在加载...
        </div>
        <%
            }%>


    </div>
</div>
</body>
</html>