<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/5/8
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Employee</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!--web路径
    不以/开始的相对路径，找资源，以当前资源的路径为基准；
    以/开始的相对路径，找资源，以服务器的路径为标准(http：//localhost:3306),需要加上项目名
    可以动态获取-->
    <!-- Bootstrap -->
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 员工更新模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="UpdateModalLabel">员工更新</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Department</label>
                        <div class="col-sm-4">
                            <%--提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_select">

                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="update_btn">Update</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<!-- 员工添加模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="AddModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="name_add" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_M" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_F" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Department</label>
                        <div class="col-sm-4">
                            <%--提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_select">

                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="save_btn">Save</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<%--    搭建bootstrap显示页面--%>
<div class="container">
    <%--        标题行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>在职员工</h1>
        </div>
    </div>
    <%--    增删按钮行--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button name="add" class="btn btn-primary" id="emp_add_modal_btn">Add</button>
            <button name="delete" class="btn btn-warning" id="emp_del_modal_btn">Delete</button>
        </div>
    </div>
    <%--        表格数据显示行--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_tab">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>ID</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>Email</th>
                    <th>Department</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--    页数显示行--%>
    <div class="row">
        <div class="col-md-6" id="page_info">

        </div>
        <%--分页信息--%>
        <div class="col-md-6" id="page_nav">
        </div>
    </div>
</div>
<script type="text/javascript">
    //总记录数
    var totalRecords,currentPage;
    // 页面加载完成之后，直接发送一个ajax请求，要到分页数据
    $(function () {
        //页面加载完，显示第一页
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                // console.log(result);
                //1.解析并显示员工信息
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条信息
                build_page_nav(result);
            }
        });
    }

    //解析并显示员工信息
    function build_emps_table(result) {
        //跳到其他页面，先清空原来的信息,下同
        $("#emps_tab tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxId = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptTd = $("<td></td>").append(item.department.deptName);
            /*
                <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                Edit
                            </button>
             */
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            //为编辑按钮添加一个自定义属性，来表示当前员工id
            editBtn.attr("edit_id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            //为删除按钮添加一个自定义属性，来表示当前员工id
            delBtn.attr("del_id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完后还是返回原来的元素
            $("<tr></tr>").append(checkBoxId).append(empIdTd)
                .append(empNameTd).append(genderTd)
                .append(emailTd).append(deptTd)
                .append(btnTd)
                .appendTo("#emps_tab tbody");
        });
    }

    //解析并显示分页信息
    function build_page_info(result) {
        //调到其他页面，先清理原来的信息
        $("#page_info").empty();

        $("#page_info").append("当前第" + result.extend.pageInfo.pageNum + "页，总"
            + result.extend.pageInfo.pages + "页，总" + result.extend.pageInfo.total + "条记录");
        totalRecords = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    // 解析显示分页条信息,点击分页能去到指定页码
    function build_page_nav(result) {
        $("#page_nav").empty();
        //构建元素
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //添加点击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        //构建元素
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            //添加点击事件
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
        }

        ul.append(firstPageLi).append(prePageLi);
        //页码号
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });

        ul.append(nextPageLi).append(lastPageLi);
        //把ul加入nav中
        var nav = $("<nav>/<nav").append(ul);
        nav.appendTo("#page_nav");
    }
    //清空表单样式及内容
    function reset_form(ele){
        $(ele)[0].reset();
        //清空样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }
    //点击新增按钮，手动调用员工添加模态框
    $("#emp_add_modal_btn").click(function () {
        //清空表单数据(数据、样式均重置)
        reset_form("#empAddModal form");
        //获取部门信息，填充模态框部门下拉列表
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop: "static", //点击背景不删
        });
    });
    function getDepts(ele) {
        //清空之前的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type: "GET",
            success:function (result) {
                $.each(result.extend.depts,function (index,item) {
                    var option = $("<option></option>").append(item.deptName).attr("value",item.deptId);
                    option.appendTo(ele);
                });
            }
        });
    }
    //校验表单数据
    function form_data_validate() {
        //拿到要校验的数据，使用正则表达式,英文|中文
        //1、校验用户名
        var empName = $("#name_add").val();
        var reg = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!reg.test(empName)){
            // alert("用户名必须是2-5位中文或6-16位字母和英文的组合");
            show_validate("#name_add","error","用户名必须是2-5位中文或6-16位字母和英文的组合")
            return false;
        }else {
            show_validate("#name_add","success","")
        }
        // 2、校验邮箱
        var email=$("#email_add").val();
        var reg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!reg.test(email)){
            // alert("邮箱格式错误");
            show_validate("#email_add","error","邮箱格式错误")
            return false;
        }else {
            show_validate("#email_add","success","");
        }

        return true;
    }

    function show_validate(ele,status,msg){
        //清楚当前元素校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if ("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //校验用户名是否可用
    $("#name_add").change(function () {
        //发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkEmp",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if (result.code==200){
                    show_validate("#name_add","success","用户名可用");
                    $("#save_btn").attr("ajax-val","success");
                }else {
                    show_validate("#name_add","error",result.extend.va_msg);
                    $("#save_btn").attr("ajax-val","error");
                }
            }
        });
    });
    //保存员工
    $("#save_btn").click(function () {
        //1、将模态框表单数据提交给服务器保存
        //2.校验表单数据
        if (!form_data_validate()){
            return false;
        }
        //判断之前的ajax用户名校验是否成功，成功则继续下面的校验
        if ($(this).attr("ajax-val")=="error"){
            return false;
        }
        //3.发送ajax请求保存
        $.ajax({
            url:"${APP_PATH}/emps",
            type:"POST",
            data:$("#empAddModal form").serialize(), // jquery方法，返回序列化的表单数据json
            success:function (result) {
                // alert(result.msg);
                if (result.code==200){
                    //保存成功
                    //1.关闭模态框
                    $("#empAddModal").modal('hide');
                    //2.跳到最后一页,也可以是一个很大的数，分页插件都会跳到最后一页
                    to_page(totalRecords);
                }else {
                    //显示失败信息
                    if (undefined != result.extend.errorFields.email){
                        //邮箱错误信息
                        show_validate("#email_add","error",result.extend.errorFields.email)
                    }

                    if (undefined != result.extend.errorFields.empName){
                        //用户名错误信息
                        show_validate("#name_add","error",result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    //因为按钮绑定点击是在按钮被创建之后的，所以会失效
    //1.可以再按钮创建时就绑定  2.绑定单机.live()，jQuery新版本没有live，用on替代
    $(document).on("click",".edit_btn",function () {
        //查询部门列表并显示
        getDepts("#empUpdateModal select");
        //查处员工信息并显示
        getEmp($(this).attr("edit_id"));
        //把员工id传递给模态框的更新按钮
        $("#update_btn").attr("edit_id",$(this).attr("edit_id"));
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emps/"+id,
            type:"GET",
            success:function (result) {
                var empDate = result.extend.emp;
                $("#empName_update_static").text(empDate.empName);
                $("#email_update").val(empDate.email);
                $("#empUpdateModal imput[name=gender]").val([empDate.gender]);
                $("#empUpdateModal select").val([empDate.dId]);
            }
        });
    }
    //点击更新，更新员工信息
    $("#update_btn").click(function () {
        // 1、校验邮箱
        var email=$("#email_update").val();
        var reg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!reg.test(email)){
            show_validate("#email_update","error","邮箱格式错误")
            return false;
        }else {
            show_validate("#email_update","success","");
        }
        //发送ajax请求，更新数据到数据库
        $.ajax({
            url:"${APP_PATH}/emps/"+$(this).attr("edit_id"),
            // type:"PUT",
            // data:$("#empUpdateModal form").serialize(),
            type:"POST",
            data:$("#empUpdateModal form").serialize()+"&_method=PUT",
            success:function (result) {
                //关闭对话框
                $("#empUpdateModal").modal("hide");
                //回到本页面
                to_page(currentPage);
            }
        });
    });
    //单个删除
    $(document).on("click",".del_btn",function () {
        //1.弹出是否确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if (confirm("确认删除【"+empName+"】吗?")){
            //确认，发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emps/"+$(this).attr("del_id"),
                type:"DELETE",
                success:function () {
                    to_page(currentPage);
                }
            });
        }
    });

    //完成全选/不选功能
    $("#check_all").click(function () {
        //attr获取自定义属性值，prop获取原生dom属性值
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //check_item
    $(document).on("click",".check_item",function () {
        //判断当前选中元素的个数是否为页面元素的个数
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });
    //批量删除
    $("#emp_del_modal_btn").click(function () {
        //遍历被选中元素,组装员工姓名、id字符串
        var empNames="";
        var del_idstr="";
        $.each($(".check_item:checked"),function () {
            empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        empNames = empNames.substring(0,empNames.length-1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if (confirm("确认删除【"+empNames+"】吗?")){
            $.ajax({
                url:"${APP_PATH}/emps/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
