<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工修改</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <p class="form-control-static" id="empName_update_static">email@example.com</p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
				    <label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
					</label>
				</div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
				    <select class="form-control" name="dId" id="dept_update_select">
					</select>
				</div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>

	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
			       <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
				    <label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked">男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
					</label>
				</div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
				    <select class="form-control" name="dId" id="dept_add_select">
					</select>
				</div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6" id="page_info_area">
			</div>
			<div class="col-md-6" id="page_nav_area">
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
		var totalRecord,currentNum;
		
		$(function(){
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH }/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result)
					build_emps_table(result);
					build_page_info(result);
					build_page_nav(result);
				}
			});
		}
		
		function build_emps_table(result){
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				editBtn.attr("edit-id",item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				delBtn.attr("del-id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				
				$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd)
				.append(genderTd).append(emailTd).append(deptNameTd)
				.append(btnTd).appendTo("#emps_table tbody");
			})
		}
		
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页,总共" 
					+result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"条记录");
			totalRecord = result.extend.pageInfo.total;
			currentNum = result.extend.pageInfo.pageNum;
		}
		
		function build_page_nav(result){
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
			firstPageLi.click(function(){
				to_page(1)
			});
			if(result.extend.pageInfo.hasPreviousPage==false){
				prePageLi.addClass("disabled");
			}else{
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1)
				});
			}
			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
				if(result.extend.pageInfo.pageNum==item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item)
				});
				ul.append(numLi);
			})
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage==false){
				nextPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1)
				});
			}
			lastPageLi.click(function(){
				to_page(result.extend.pageInfo.pages);
			});
			ul.append(nextPageLi).append(lastPageLi);
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
			//$("#page_nav_area").append(navEle);	
		}
		
		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		$("#emp_add_modal_btn").click(function(){
			reset_form("#empAddModal form");
			//$("#empAddModal form")[0].reset();
			getDepts("#empAddModal select");
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		function getDepts(ele){
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result);
					//$("#dept_add_select")
					//$("#empAddModal select").append("")
					$.each(result.extend.depts,function(){
						var optionEle =$("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		function validate_add_form(){
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
				//$("#empName_add_input").parent.addClass("has-error");
				//$("#empName_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
				//$("#empName_add_input").parent.addClass("has-success");
				//$("#empName_add_input").next("span").text("");
			}
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				show_validate_msg("#email_add_input","error","邮箱格式不正确");
				//$("#email_add_input").parent.addClass("has-error");
				//$("#email_add_input").next("span").text("邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_add_input","success","");
				//$("#email_add_input").parent.addClass("has-success");
				//$("#email_add_input").next("span").text("");
			}
			return true;
		}
		
		function show_validate_msg(ele,status,msg){
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		$("#empName_add_input").change(function(){
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkUser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		
		$("#emp_save_btn").click(function(){
			/* if(!validate_add_form()){
				return false;
			} */
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.message);
					if(result.code==100){
						$("#empAddModal").modal('hide');
						to_page(totalRecord);
					}else{
						//console.log(result);
						if(undefined != result.extend.errorFields.email){
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined != result.extend.errorFields.empName){
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
						}
					}
				}
			});
		});
		
		$(document).on("click",".delete_btn",function(){
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
			if(confirm("确认删除【"+empName+"】吗？")){
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.message);
						to_page(currentNum);
					}
				});
			}
		});
		
		$(document).on("click",".edit_btn",function(){
			getDepts("#empUpdateModal select");
			getEmp($(this).attr("edit-id"));
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
					
				}
			})
		}
		
		$("#emp_update_btn").click(function(){
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_update_input","success","");
			}
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//console.log(result);
					$("#empUpdateModal").modal('hide');
					to_page(currentNum);
				}
			});
		});
		
		$("#check_all").click(function(){
			//attr获取自定义属性值，prop获取dom原生值
			//$(this).prop("checked");
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		$(document).on("click",".check_item",function(){
			var flag = $(".check_item:checked").length==$(".check_item").length
			$("#check_all").prop("checked",flag);
		});
		
		$("#emp_delete_all_btn").click(function(){
			var empNames = "";
			var ids = "";
			$.each($(".check_item:checked"),function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				ids += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			ids = ids.substring(0,ids.length-1);
			if(confirm("确认删除【"+empNames.substring(0,empNames.length-1)+"】吗？")){
				$.ajax({
					url:"${APP_PATH}/emp/"+ids,
					type:"DELETE",
					success:function(result){
						alert(result.message);
						to_page(currentNum);
					}
				});
			}
		});
	</script>
</body>
</html>