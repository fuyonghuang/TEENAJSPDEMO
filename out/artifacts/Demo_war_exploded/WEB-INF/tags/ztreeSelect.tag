<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="url" type="java.lang.String" required="false" %>
<%@ attribute name="title" type="java.lang.String" required="false" %>
<%@attribute name="inputName" type="java.lang.String" required="false" %>

<input onclick="showDialog()" type="text" name="${inputName}">
<script>
  function showDialog() {
    top.dialog({
      id: "treeSelect",
      title: "${title}",
      url: '/topGover/ztreeSelect.jsp?url=${url}',
      width: 300,
      height: 400,
      button: [{
        id: 'ok',
        value: '选择',
        callback: function () {
          var tree = top.$("div[role=dialog]").find("iframe")[0].contentWindow.treeDemo;
          console.log(tree);
        }
      }]
    }).show();
  }


</script>