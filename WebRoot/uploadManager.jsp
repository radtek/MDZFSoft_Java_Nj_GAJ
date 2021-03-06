<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.manager.pub.bean.*, com.manager.pub.util.*, java.util.*" %>
<%!
public boolean canDown(Object roleFormSession) {
	boolean can = false;
	RoleForm roleForm = null;
	if(roleFormSession!=null) {
		try {
			roleForm = (RoleForm)roleFormSession;
			String[] urls = roleForm.getUrlIdList().split(",");
			for(String url: urls) {
				if(url.equals("12")){//下载权限
					can = true;
				}
			}
		} catch(Exception ex) {
			can = false;
		}
	}
	return can;
}
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserForm userForm = null;
if(request.getSession().getAttribute(Constants.SESSION_USER_FORM)!=null) {
	userForm = (UserForm)request.getSession().getAttribute(Constants.SESSION_USER_FORM);
}
	com.manager.pub.bean.Page pageRst = null;
	List<UploadForm> uploadFormList = null;
	if(request.getAttribute(Constants.PAGE_INFORMATION)!=null)
	{
		pageRst = (com.manager.pub.bean.Page)request.getAttribute(Constants.PAGE_INFORMATION);
		uploadFormList = (List<UploadForm>)pageRst.getListObject();
	}
String uploadUserName = request.getParameter("uploadUser")==null?"":request.getParameter("uploadUser");
String createUserName = request.getParameter("uploadCreate")==null?"":request.getParameter("uploadCreate");


String fileStatsVal = request.getParameter("fileStats")==null?"":request.getParameter("fileStats");

String nullRemarkCheck = request.getParameter("nullRemark")==null?"":(request.getParameter("nullRemark").equals("")?"":"checked");
String nullPoliceCodeCheck = request.getParameter("nullPoliceCode")==null?"":(request.getParameter("nullPoliceCode").equals("")?"":"checked");
String nullPoliceDescCheck = request.getParameter("nullPoliceDesc")==null?"":(request.getParameter("nullPoliceDesc").equals("")?"":"checked");
String nullPoliceTimeCheck = request.getParameter("nullPoliceTime")==null?"":(request.getParameter("nullPoliceTime").equals("")?"":"checked");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>个人中心统计报表</title>
<jsp:include page="common/tag.jsp" />
<script type="text/javascript" src="<%=basePath %>js/jquery_dialog.js"></script>
<script type="text/javascript" src="<%=basePath %>pagejs/uploadManager.js"></script>
<script type="text/javascript" src="<%=basePath %>js/adddate.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#dialog").click(function(){
	$.weeboxs.open('.boxcontent', {title:'统计表报',contentType:'selector'});
});})



</script>
</head>

<body>

	<!--header=============================================begin-->
<jsp:include page="common/header.jsp" />
<script>var menuIndex = 3;</script>
<jsp:include page="common/menu.jsp" />
	<!--content============================================begin-->
	<div id="container">
		<div class="layout clearfix">
			<div class="white_p10">
					<h4 class="content_hd long_content_hd">文件查看</h4>
					<div class="content_bd">
						<div class="gray_bor_bg">
							<h5 class="gray_blod_word">组合条件搜索</h5>
							<div class="search_form">
<form id="uploadManagerForm" action="<%=basePath %>userAction.do?method=filePlayShow" onsubmit="return uploadManagerFormSubmit()" method="post">
<input type="hidden" name="uploadUserId" id="upload_userId" value="<%=request.getParameter("uploadUserId")==null?"":request.getParameter("uploadUserId") %>" />
<input type="hidden" name="fileCreateUserId" id="upload_editId" value="<%=request.getParameter("fileCreateUserId")==null?"":request.getParameter("fileCreateUserId") %>" />
								<div class="mt_10">
								<label>文&nbsp;件&nbsp;名:</label>
									<input type="text" class="input_168x19" name="uploadName" id="uploadName" value="<%=request.getParameter("uploadName")==null?"":request.getParameter("uploadName") %>" />&nbsp;&nbsp;&nbsp;&nbsp;
								<label>文件备注:</label><input class="input_168x19" type="text" id="fileRemark" name="fileRemark" value="<%=request.getParameter("fileRemark")==null?"":request.getParameter("fileRemark") %>" />
								<input type="checkbox" value="1" name="nullRemark" onclick="isObjNull(this, 'fileRemark')" <%=nullRemarkCheck %>/>为空
								</div>
								<div class="mt_10">
								<label>到达时间:</label>
									<input type="text" class="input_38x19" name="useTime_begin" id="useTime_begin" value="<%=request.getParameter("useTime_begin")==null?"":request.getParameter("useTime_begin") %>" />&nbsp;&nbsp;-&nbsp;&nbsp;<input type="text" class="input_38x19" name="useTime_end" id="useTime_end" value="<%=request.getParameter("useTime_end")==null?"":request.getParameter("useTime_end") %>" /> 分钟内
								</div>
								<div class="mt_10">
								<label>上传民警:</label>
									<input type="text" class="input_168x19" name="uploadUserName" id="userName" readonly onclick="userChoose('1212')" value="<%=request.getParameter("uploadUserName")==null?"":request.getParameter("uploadUserName") %>" />&nbsp;&nbsp;&nbsp;&nbsp;
								<label>处警民警:</label><input type="text" class="input_168x19" name="uploadEditName" id="editName" readonly onclick="userChoose()" value="<%=request.getParameter("uploadEditName")==null?"":request.getParameter("uploadEditName") %>"/>&nbsp;&nbsp;&nbsp;&nbsp;
								<label style="display:none">文件重要性:</label></div>
								<div class="mt_10">
								<label>接警编号:</label>
									<input class="input_386x25" id="policeCode" type="text" name="policeCode" value="<%=request.getParameter("policeCode")==null?"":request.getParameter("policeCode") %>"/>
									<input type="checkbox" value="1" name="nullPoliceCode" onclick="isObjNull(this, 'policeCode')" <%=nullPoliceCodeCheck %>/>为空
								</div>
								<div class="mt_10">
								<label>简要警情:</label>
									<input class="input_386x25" id="policeDesc" type="text" name="policeDesc" value="<%=request.getParameter("policeDesc")==null?"":request.getParameter("policeDesc") %>"/>
									<input type="checkbox" value="1" name="nullPoliceDesc" onclick="isObjNull(this, 'policeDesc')" <%=nullPoliceDescCheck %>/>为空
								</div>
								<%
									if(userForm!=null && userForm.getUserId()==0) {
								%>
								<div class="mt_10">
								<label>录制时间:</label>
									<input class="input_168x19" id="takeTime_begin" type="text" name="takeTime_begin" value="<%=request.getParameter("takeTime_begin")==null?"":request.getParameter("takeTime_begin") %>" onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss')" readonly />&nbsp;&nbsp;-&nbsp;&nbsp;<input type="text" id="takeTime_end" class="input_168x19" name="takeTime_end" value="<%=request.getParameter("takeTime_end")==null?"":request.getParameter("takeTime_end") %>" onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss')" readonly />
								</div>
								<%
									}
								%>
								<div class="mt_10">
								<label>接警时间:</label>
									<input class="input_168x19" id="policeTime_begin" type="text" name="policeTime_begin" value="<%=request.getParameter("policeTime_begin")==null?"":request.getParameter("policeTime_begin") %>" onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss')" readonly />&nbsp;&nbsp;-&nbsp;&nbsp;<input type="text" id="policeTime_end" class="input_168x19" name="policeTime_end" value="<%=request.getParameter("policeTime_end")==null?"":request.getParameter("policeTime_end") %>" onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss')" readonly />
									<input type="checkbox" value="1" name="nullPoliceTime" onclick="isObjNull(this, 'policeTime_begin,policeTime_end')" <%=nullPoliceTimeCheck %>/>为空
								</div>
								<div class="mt_10">
								<label>上传时间:</label>
									<input class="input_168x19" id="beginTime" type="text" name="beginTime" value="<%=request.getParameter("beginTime")==null?"":request.getParameter("beginTime") %>" onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss')" readonly />&nbsp;&nbsp;-&nbsp;&nbsp;<input type="text" id="endTime" class="input_168x19" name="endTime" value="<%=request.getParameter("endTime")==null?"":request.getParameter("endTime") %>" onclick="SelectDate(this,'yyyy-MM-dd hh:mm:ss')" readonly />
									<select name="fileStats" class="select_79x19" style="display:none">
										<option value=""<%=fileStatsVal.equals("")?"selected":""%>>--</option>
										<option value="0"<%=fileStatsVal.equals("0")?"selected":""%>>普通</option>
										<option value="1"<%=fileStatsVal.equals("1")?"selected":""%>>重要</option>
									</select>
								<!--label>文件备注:</label><input type="text" class="input_79x19" name="fileRemark" value="<%=request.getParameter("fileRemark")==null?"":request.getParameter("fileRemark") %>"/-->
								</div>
								<div class="mt_10">
								<label>所属部门：</label>
									<select name="treeId" class="input_130x20">
										<option value=""> -- </option>
<%
	String treeId = request.getParameter("treeId")==null?"":request.getParameter("treeId");
	List list_totalTree = (List)request.getAttribute(Constants.JSP_TREE_LIST);
	if(list_totalTree!=null && list_totalTree.size()>0)
	{
		for(int i=0; i<list_totalTree.size(); i++)//一级部门循环
		{
			TreeForm rootTreeForm = (TreeForm)((List)(list_totalTree.get(i))).get(0);
			List<TreeForm> treeFormList = ((List<TreeForm>)((List)(list_totalTree.get(i))).get(1));
%>
										<option value="<%=rootTreeForm.getTreeId() %>"<%=treeId.equals(rootTreeForm.getTreeId()+"")?" selected":"" %>><%=rootTreeForm.getTreeName() %></option>
<%
			for(int j=0; j<treeFormList.size(); j++)//二级部门循环
			{
%>
										<option value="<%=treeFormList.get(j).getTreeId() %>"<%=treeId.equals(treeFormList.get(j).getTreeId()+"")?" selected":"" %>>&nbsp;<%=treeFormList.get(j).getTreeName() %></option>
<%
			}
		}
	}
%>
									</select>
								</div>
								<div class="mt_10">
								<label>视频类型：</label>
									<jsp:include page="common/policeType.jsp?showAll="></jsp:include>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" class="blue_mod_btn" value="搜 &nbsp;索" />
								</div>
</form>
							</div>
							
						</div>
						<div class=" mt_10">
							<ul class="upload_list">
							<%
							if(uploadFormList!=null && uploadFormList.size()>0)
							{
								for(int i=0; i<uploadFormList.size(); i++)
								{
									UploadForm uploadForm = uploadFormList.get(i);
							%>
								<li class="upload_item">
									<div class="upload_img">
										<%
											if(uploadForm.getPlayPath()!=null && uploadForm.getPlayPath().length()>4) {
												if(uploadForm.getPlayPath().substring(uploadForm.getPlayPath().length()-4).toLowerCase().equals(".jpg"))
												{
										%>
										<a href="javascript:imageDialogShow('<%=uploadForm.getFileSavePath()+uploadForm.getPlayPath() %>','','查看图片');" >
										<img src="<%=uploadForm.getFileSavePath()+uploadForm.getShowPath() %>" alt="" width="160px" height="160px" />
										</a>
										<%
												}
												else if(uploadForm.getPlayPath().substring(uploadForm.getPlayPath().length()-4).toLowerCase().equals(".wav"))
												{
													if(uploadForm.getFileState().equals("A")) {
										%>
										<a href="javascript:playWavDialogShow('<%=uploadForm.getFileSavePath()+uploadForm.getPlayPath() %>','','播放音频');" >
										<%
													}
										%>
										<img title="<%=uploadForm.getFileRemark()==null?"":uploadForm.getFileRemark() %>" src="<%=uploadForm.getFileSavePath()+uploadForm.getShowPath() %>" alt="" width="160px" height="160px" />
										<%
													if(uploadForm.getFileState().equals("A")) {
										%>
										</a>
										<%
													}
												}
												else//mp4
												{
													if(uploadForm.getFileState().equals("A")) {
										%>
										<a href="javascript:playFlvDialogShow('<%=uploadForm.getFileSavePath()+uploadForm.getFlvPath() %>','','播放视频');" >
										<%
													}
										%>
										<img title="<%=uploadForm.getFileRemark()==null?"":uploadForm.getFileRemark() %>" src="<%=uploadForm.getFileSavePath()+uploadForm.getShowPath() %>" alt="" width="160px" height="160px" />
										<%
													if(uploadForm.getFileState().equals("A")) {
										%>
										</a>
										<%
													}
												}
											}
										%>
									</div>
									<div title="<%=uploadForm.getUploadName() %>" class="upload_descript" style="width:140px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
										<%=uploadForm.getUploadName() %>
									</div>
									<div class="upload_opterdetails">
										<ul>
											<!--li>
												<span class="hd">上传时间</span>
												<span class="bd"><%=Constants.timeFormat(uploadForm.getUploadTime(), "1").substring(2,16) %></span>
											</li-->
											<li>
												<span class="hd" style="display:block;width:148px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="接警编号：<%=uploadForm.getPoliceCode()==null?"":uploadForm.getPoliceCode() %>">
												接警编号：
												<%=uploadForm.getPoliceCode()==null?"":uploadForm.getPoliceCode() %>
												</span>
											</li>
								<%
									if(userForm!=null && userForm.getUserId()==0) {
								%>
											<li>
												<span class="hd">到达时间：</span>
												<span class="bd"><%
												if(uploadForm.getUseTime()!=null && uploadForm.getUseTime()>0) {
													out.print(uploadForm.getUseTime()+"分钟");
												}
												%></span>
											</li>
											<li>
												<span class="hd">录制时间：</span>
												<span class="bd"><%
												if(uploadForm.getTakeTime()!=null && uploadForm.getTakeTime().length()==14) {
													String takeTimeFormat = Constants.timeFormat(uploadForm.getTakeTime(), "1");
													out.print(takeTimeFormat.length()>16?takeTimeFormat.substring(2,16):takeTimeFormat);
												}
												%></span>
											</li>
								<%
									}
								%>
											<li>
												<span class="hd">接警时间：</span>
												<span class="bd"><%
												if(uploadForm.getPoliceTime()!=null && uploadForm.getPoliceTime().length()==14) {
													String policeTimeFormat = Constants.timeFormat(uploadForm.getPoliceTime(), "1");
													out.print(policeTimeFormat.length()>16?policeTimeFormat.substring(2,16):policeTimeFormat);
												}
												%></span>
											</li>
											<li>
												<span class="hd">处警民警：</span>
												<span class="bd"><%=uploadForm.getEditName() %></span>
											</li>
											
											<li>
												<span class="hd">上传民警：</span>
												<span class="bd"><%=uploadForm.getUserName() %></span>
											</li>
											<li>
												<span class="hd">所属部门：</span>
												<span class="bd"><%=uploadForm.getTreeEditName() %></span>
											</li>
										</ul>
									</div>
									<div class="clearfix mt_10">
										<!--a href="" class="fl cancle">取消</a-->
										<%
											if(userForm!=null && userForm.getUserId()==0) {
										%>
										<a href="javascript:detailShow('<%=uploadForm.getUploadId() %>')" class="blue_mod_btn fr" style="width:30px">摘要</a>
										<%
											}
										%>
										<%
											if(canDown(request.getSession().getAttribute(Constants.SESSION_ROLE_FORM))) {
										%>
										<a href="<%=uploadForm.getFileSavePath()+uploadForm.getPlayPath() %>" target="_blank" class="blue_mod_btn fr" style="width:30px">下载</a>
										<%
											}
										%>
										<%
											if(uploadForm.getPlayPath()!=null && uploadForm.getPlayPath().length()>4) {
												if(uploadForm.getPlayPath().substring(uploadForm.getPlayPath().length()-4).toLowerCase().equals(".jpg"))
												{
										%>
										<a href="javascript:imageDialogShow('<%=uploadForm.getFileSavePath()+uploadForm.getPlayPath() %>','','查看图片');" style="width:30px" class="blue_mod_btn fr">查看</a>
										<%
												}
												else if(uploadForm.getPlayPath().substring(uploadForm.getPlayPath().length()-4).toLowerCase().equals(".wav"))
												{
													if(uploadForm.getFileState().equals("A")) {
										%>
										<a href="javascript:playWavDialogShow('<%=uploadForm.getFileSavePath()+uploadForm.getPlayPath() %>','','播放音频');" style="width:30px" class="blue_mod_btn fr">播放</a>
										<%
													} else {
										%>
										<a href="javascript:alert('视频正在剪辑中，请稍后');" class="blue_mod_btn fr">剪辑中...</a>
										<%
													}
												}
												else//mp4
												{
													if(uploadForm.getFileState().equals("A")) {
										%>
										<a href="javascript:playFlvDialogShow('<%=uploadForm.getFileSavePath()+uploadForm.getFlvPath() %>','','播放视频');" style="width:30px" class="blue_mod_btn fr">播放</a>
										<%
													} else {
										%>
										<a href="javascript:alert('视频正在剪辑中，请稍后');" class="blue_mod_btn fr">剪辑中...</a>
										<%
													}
												}
											}
										%>
										<%
										// 20130613 EditBy 孙强伟
											if(uploadForm.getPoliceCode()!=null && uploadForm.getPoliceCode().length()!=0){
										%>
										<a href="javascript:jjxxDetailShow('<%=uploadForm.getPoliceCode() %>')" class="blue_mod_btn fr">警综信息</a>
										<%	
											}
										 %>
									</div>
								</li>
							<%
								}
							}
							%>
							</ul>
<form action="<%=basePath %>userAction.do?method=filePlayShow" method="post" id="hidUploadForm">
<input type="hidden" name="nullRemark" value="<%=request.getParameter("nullRemark")==null?"":request.getParameter("nullRemark") %>" />
<input type="hidden" name="nullPoliceCode" value="<%=request.getParameter("nullPoliceCode")==null?"":request.getParameter("nullPoliceCode") %>" />
<input type="hidden" name="nullPoliceDesc" value="<%=request.getParameter("nullPoliceDesc")==null?"":request.getParameter("nullPoliceDesc") %>" />
<input type="hidden" name="nullPoliceTime" value="<%=request.getParameter("nullPoliceTime")==null?"":request.getParameter("nullPoliceTime") %>" />
<input type="hidden" name="pageCute" id="uploadManager_pageCute" />
<input type="hidden" name="treeId" value="<%=request.getParameter("treeId")==null?"":request.getParameter("treeId") %>" />
<input type="hidden" name="uploadName" value="<%=request.getParameter("uploadName")==null?"":request.getParameter("uploadName") %>" />
<input type="hidden" name="fileRemark" value="<%=request.getParameter("fileRemark")==null?"":request.getParameter("fileRemark") %>" />
<input type="hidden" name="beginTime" value="<%=request.getParameter("beginTime")==null?"":request.getParameter("beginTime") %>" />
<input type="hidden" name="endTime" value="<%=request.getParameter("endTime")==null?"":request.getParameter("endTime") %>" />
<input type="hidden" name="uploadUserName" value="<%=request.getParameter("uploadUserName")==null?"":request.getParameter("uploadUserName") %>" />
<input type="hidden" name="uploadEditName" value="<%=request.getParameter("uploadEditName")==null?"":request.getParameter("uploadEditName") %>" />
<input type="hidden" name="uploadUserId" value="<%=request.getParameter("uploadUserId")==null?"":request.getParameter("uploadUserId") %>" />
<input type="hidden" name="fileCreateUserId" value="<%=request.getParameter("fileCreateUserId")==null?"":request.getParameter("fileCreateUserId") %>" />
<input type="hidden" name="fileStats" value="<%=fileStatsVal %>" />
<input type="hidden" name="takeTime_begin" value="<%=request.getParameter("takeTime_begin")==null?"":request.getParameter("takeTime_begin") %>" />
<input type="hidden" name="takeTime_end" value="<%=request.getParameter("takeTime_end")==null?"":request.getParameter("takeTime_end") %>" />
<input type="hidden" name="policeTime_begin" value="<%=request.getParameter("policeTime_begin")==null?"":request.getParameter("policeTime_begin") %>" />
<input type="hidden" name="policeTime_end" value="<%=request.getParameter("policeTime_end")==null?"":request.getParameter("policeTime_end") %>" />
<input type="hidden" name="policeCode" value="<%=request.getParameter("policeCode")==null?"":request.getParameter("policeCode") %>" />
<input type="hidden" name="policeDesc" value="<%=request.getParameter("policeDesc")==null?"":request.getParameter("policeDesc") %>" />
<input type="hidden" name="useTime_begin" value="<%=request.getParameter("useTime_begin")==null?"":request.getParameter("useTime_begin") %>" />
<input type="hidden" name="useTime_end" value="<%=request.getParameter("useTime_end")==null?"":request.getParameter("useTime_end") %>" />
<input type="hidden" name="policeType" value="<%=request.getParameter("policeType")==null?"":request.getParameter("policeType") %>" />
</form>
<script>
function showUpload(pageCute)
{
	$('#uploadManager_pageCute').val(pageCute);
	$('#hidUploadForm').submit();
}
</script>
							<table align="center"><tr><td><jsp:include page="common/page.jsp?function=showUpload"></jsp:include></td></tr></table>
						</div>
						<div class=" mt_10 pb_200">
							
						</div>
					</div>
				</div>
			</div>
	</div>
<div id="imgShowDiv" icon="icon-save" style="display:none" class="boxcontent">
<img id="imgObj" src="" />
</div>
<div id="playShowDiv" icon="icon-save" style="display:none" class="boxcontent">
<object id="video" name="video" width="640" height="480" border="0" classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA">
<param name="ShowDisplay" value="0">
<param name="ShowControls" value="1">
<param name="AutoStart" value="1">
<param name="AutoRewind" value="0">
<param name="PlayCount" value="-1">
<param name="Appearance" value="0" value="">
<param name="BorderStyle" value="0" value="">
<param name="MovieWindowHeight" value="570">
<param name="MovieWindowWidth" value="440">
<param name="FileName" value="" id="playObj">
<embed id="videoObj" width="570" height="440" border="0" showdisplay="0" showcontrols="1" autostart="1" autorewind="0" playcount="-1" moviewindowheight="570" moviewindowwidth="440" filename="" src=""> 
</embed>
</object>
</div>
<div id="playFlvDiv" icon="icon-save" style="display:none" class="boxcontent">
<object id="flv" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" height="640" width="480"> 
<param name="movie" id="flvplayObj" value="vcastr22.swf?vcastr_file="> 
<param name="quality" value="high"> 
<param name="allowFullScreen" value="true" /> 
<embed id="flvvideoObj" src="vcastr22.swf?vcastr_file=" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" 
type="application/x-shockwave-flash" width="640" height="480"> 
</embed> 
</object>
</div>
<div id="playFlvFrame" icon="icon-save" style="display:none" class="boxcontent">
<iframe src="" name="flvplay" frameborder="0" width="560" height="420" scrolling="no"></iframe>
</div>
<div id="playWavFrame" icon="icon-save" style="display:none" class="boxcontent">
<iframe src="" name="wavplay" frameborder="0" width="420" height="100" scrolling="no"></iframe>
</div>
<div id="userChooseDiv" icon="icon-save" style="display:none" class="boxcontent">
<div class="gray_bor_bg">
<div class="error msg" id="userChooseMsg" style="display:none" onclick="hideObj('userChooseMsg')">Message if login failed</div>
							<h5 class="gray_blod_word">组合条件搜索</h5>
							<div class="search_form">
					<form id="userManagerForm" name="userManagerForm" target="userChooseIframe" action="<%=basePath %>userAction.do?method=userSelect" method="post">
								<input type="hidden" name="changeUser" id="changeUser" value="0"/>
								<label>姓名：</label><input type="text" name="user_name" value="" class="input_79x19"/>&nbsp;&nbsp;&nbsp;&nbsp;
								<label>警员编号：</label><input type="text" name="user_code" value="" class="input_79x19"/>&nbsp;&nbsp;&nbsp;&nbsp;
								<label>所属部门：</label>
										<select name="query_treeId" class="input_130x20">
											<option value=""> -- </option>
<%
	//List list_totalTree = (List)request.getAttribute(Constants.JSP_TREE_LIST);
	if(list_totalTree!=null && list_totalTree.size()>0)
	{
		for(int i=0; i<list_totalTree.size(); i++)//一级部门循环
		{
			TreeForm rootTreeForm = (TreeForm)((List)(list_totalTree.get(i))).get(0);
			List<TreeForm> treeFormList = ((List<TreeForm>)((List)(list_totalTree.get(i))).get(1));
%>
											<option value="<%=rootTreeForm.getTreeId() %>"><%=rootTreeForm.getTreeName() %></option>
<%
			for(int j=0; j<treeFormList.size(); j++)//二级部门循环
			{
%>
											<option value="<%=treeFormList.get(j).getTreeId() %>">&nbsp;<%=treeFormList.get(j).getTreeName() %></option>
<%
			}
		}
	}
%>
										</select>
								<input type="submit" class="blue_mod_btn" value="搜 &nbsp;索" />
								<a id="closeDialog" style="display:none" href="javascript:void(0)" class="Js_closePar blue_mod_btn" class="">取&nbsp;&nbsp;消</a>
					</form>
							</div>
						</div>
						<iframe src="" name="userChooseIframe" width="578" height="330" frameborder="0" scrolling="no"></iframe>
</div>

<script>
/**
 * 用户选择
 * @param assignmentId 
 * @param assignmentName 
 * @param dialogTitle 弹出层的标题
 */
function userChoose(assignmentId, assignmentName, dialogTitle, onlyRoot)
{
jQuery(function($) {
	$.weeboxs.open('#userChooseDiv', {title:dialogTitle, contentType:'selector', width:'600', height:'450'});
	if(assignmentId!=null)
	{
		$('#changeUser').val('0');
	}
	else
	{
		$('#changeUser').val('');
	}
});
}
function closeDialog()
{
	$('#closeDialog').click();
}

function isObjNull(obj,objName){
jQuery(function($) {
	if(obj.checked){
		var objNameArr = objName.split(',');
		for(var i=0; i<objNameArr.length; i++) {
			$('#'+objNameArr[i]).val('');
		}
	}
});
}
</script>
<jsp:include page="common/footer.jsp" />
<script type="text/javascript" src="js/all.js"></script>
<form id="playFlvDivForm" action="videoPlayer/play.jsp" method="post" target="flvplay">
<input type="hidden" id="flvPath" name="flvPath" />
</form>
<form id="playWavDivForm" action="wavplay.jsp" method="post" target="wavplay">
<input type="hidden" id="wavPath" name="wavPath" />
</form>
</body>
</html>
