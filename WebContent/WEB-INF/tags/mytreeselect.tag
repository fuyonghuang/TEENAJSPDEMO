<%@ tag language="java" pageEncoding="UTF-8" %>

<%--<%@ include file="/WEB-INF/views/include/taglib.jsp" %>--%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号" %>
<%@ attribute name="name" type="java.lang.String" required="true" description="隐藏域名称（ID）" %>
<%@ attribute name="value" type="java.lang.String" required="true" description="隐藏域值（ID）" %>
<%@ attribute name="labelName" type="java.lang.String" required="true" description="输入框名称（Name）" %>
<%@ attribute name="labelValue" type="java.lang.String" required="true" description="输入框值（Name）" %>
<%@ attribute name="title" type="java.lang.String" required="true" description="选择框标题" %>
<%@ attribute name="url" type="java.lang.String" required="true" description="树结构数据地址" %>
<%@ attribute name="checked" type="java.lang.Boolean" required="false"
              description="是否显示复选框，如果不需要返回父节点，请设置notAllowSelectParent为true" %>
<%@ attribute name="extId" type="java.lang.String" required="false" description="排除掉的编号（不能选择的编号）" %>
<%@ attribute name="noextid" type="java.lang.String" required="false" description="不能选择的编号(修改版)" %>
<%@ attribute name="isAll" type="java.lang.Boolean" required="false"
              description="是否列出全部数据，设置true则不进行数据权限过滤（目前仅对Office有效）" %>
<%@ attribute name="notAllowSelectRoot" type="java.lang.Boolean" required="false"
              description="不允许选择根节点" %>
<%@ attribute name="notAllowSelectParent" type="java.lang.Boolean" required="false"
              description="不允许选择父节点" %>
<%@ attribute name="module" type="java.lang.String" required="false"
              description="过滤栏目模型（只显示指定模型，仅针对CMS的Category树）" %>
<%@ attribute name="selectScopeModule" type="java.lang.Boolean" required="false"
              description="选择范围内的模型（控制不能选择公共模型，不能选择本栏目外的模型）（仅针对CMS的Category树）" %>
<%@ attribute name="allowClear" type="java.lang.Boolean" required="false" description="是否允许清除" %>
<%@ attribute name="allowInput" type="java.lang.Boolean" required="false" description="文本框可填写" %>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="class样式" %>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式" %>
<%@ attribute name="hideBtn" type="java.lang.Boolean" required="false" description="是否显示按钮" %>
<%@ attribute name="disabled" type="java.lang.String" required="false"
              description="是否限制选择，如果限制，设置为disabled" %>
<%@ attribute name="dataMsgRequired" type="java.lang.String" required="false" description="" %>
<%@ attribute name="tagAndClidId" type="java.lang.String" required="false"
              description="获取目标所有的子节点" %>
<%@ attribute name="isJYJCheckRecordsForm" type="java.lang.String" required="false"
              description="是否是教育局日常抽查页面源" %>
<%@ attribute name="isFileUploadTypeEdit" type="java.lang.String" required="false"
              description="是否是资源类型修改页面" %>

<!-- 任务下发的指定人员检查系列 -->
<input id="${id}Id" name="${name}" type="hidden" value="${value}"/>
<input id="${id}Parents" type="hidden" value=""/>
<input id="${id}tagAndClidId" type="hidden" value="${tagAndClidId}"/>

<div class="input-group">
    <input id="${id}Name"
           name="${labelName}" class="n_input_text"
    ${allowInput ? '' : 'readonly="readonly"'}
           type="text"
           value="${labelValue}"
           data-msg-required="${dataMsgRequired}"
           class="form-control ${cssClass}"
           style="${cssStyle}">
    <a id="${id}Button"
       href="javascript:void(0);"
       class="btn ${disabled} ${hideBtn ? 'hide-element' : 'btn-default'} input-group-addon">
        <i class="glyphicon glyphicon-search"></i>
    </a>
</div>
<script>
  $("#${id}Button, #${id}Name").click(function () {
    // 是否限制选择，如果限制，设置为disabled
    if ($("#${id}Button").hasClass("disabled")) {
      return true;
    }
    // 正常打开:
    top.dialog({
      id: "treeSelect",
      title: "选择${title}",
      url: "/tagTreeselect.jsp?url=${url}",
      width: 300,
      height: 400,
      button: [{
        id: 'ok',
        value: '选择',
        callback: function () {
          debugger
          var tree = top.$("div[role=dialog]").find("iframe")[0].contentWindow.tree;
          var ids = [], names = [], nodes = [], parents = "";
          if ("${checked}" == "true") {
            nodes = tree.getCheckedNodes(true);
            // 已选了但隐藏的也加进来
            var hiddenNodeList = tree.getNodesByFilter(function (node) {
              return node.isHidden == true && node.checked == true && node.halfCheck == false
            });
            nodes = nodes.concat(hiddenNodeList);
          } else {
            if ($("#fileUploadTypeId").length > 0 && typeof checkType != "undefined") {
              checkType();
            } else if ("${cssClass}" == "required") {
              $("#${id}Name").valid();
            }
            if ("${isJYJCheckRecordsForm}" == "true") {
              flushTable("");
            }
            nodes = tree.getSelectedNodes();
          }

          for (var i = 0; i < nodes.length; i++) {

            ids.push(nodes[i].id);
            names.push(nodes[i].name);//<c:if test="${!checked}">

            //返回被选择的所以父类ID 集合
            parents = nodes[i].pIds;
            if ("${isJYJCheckRecordsForm}" == "true") {
              flushTable(nodes[i].id);
            }

            // 如果为非复选框选择，则返回第一个选择 </c:if>
          }
          $("#${id}Id").val(ids.join(",").replace(/u_/ig, "")).trigger('change');
          $("#${id}Name").val(names.join(",")).trigger('change');

          //<c:if test="${!checked}">
          $("#${id}Parents").val(parents).change();
          // </c:if>

          if ($("#fileUploadTypeId").length > 0 && typeof checkType != "undefined") {
            checkType();
          } else if ("${cssClass}" == "required") {
            $("#${id}Name").valid();
          }
        },
        autofocus: true
      },//<%--<c:if test="${allowClear}">
        {
          value: '清除',
          callback: function () {
            $("#${id}Id").val("");
            $("#${id}Name").val("");
            $("#${id}Parents").val("");
            if ($("#fileUploadTypeId").length > 0 && typeof checkType != "undefined") {
              checkType();
            } else if ("${cssClass}" == "required") {
              $("#${id}Name").valid();
            }
            if ("${isJYJCheckRecordsForm}" == "true") {
              flushTable("");
            }
          }
        },//</c:if>--%>
        {
          value: '关闭'
        }],
      onclose: function () {
        if (this.returnValue) {
        }
        this.remove();
      }
    }).show();
  });
</script>