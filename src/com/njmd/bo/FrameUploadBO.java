package com.njmd.bo;

import java.util.List;

import com.manager.pub.bean.Page;
import com.manager.pub.bean.PoliceTypeForm;
import com.manager.pub.bean.UploadForm;


public interface FrameUploadBO {
	/**
	 * 用户文件上传
	 * 
	 * @param uploadForm
	 * 			userId;			上传人id
	 * 			editId;			采集人id
	 * 			uploadName;		上传文件名
	 * 			playPath;		播放地址
	 * 			fileCreatetime;	文件创建时间
	 * 			showPath;		文件预览地址
	 * 			uploadTime;		上传时间
	 * 			fileState;		上传文件状态 A-有效；U-无效；F-过期
	 * 			tree1Id;		上传人部门id
	 * 			tree2Id;		上传人上级部门id
	 * 			fileStats;		文件重要性
	 * 			fileRemark;		文件备注说明
	 * 			ipAddr;			上传人IP地址
	 * 			fileSavePath;	文件保存查看前缀地址
	 * 			flvPath;		flv播放地址
	 * @return 0-成功； 1-失败 系统异常；
	 */
	public int uploadSave(UploadForm uploadForm);

	/**
	 * 文件详情
	 * 
	 * @param uploadId	上传文件id
	 * @return
	 */
	public UploadForm uploadDetail(java.lang.Long uploadId);

	/**
	 * 文件加☆★
	 * 
	 * @param uploadId	上传文件id
	 * @param fileStats	1-重要；0-不重要；
	 * @return 0-成功； 1-失败 系统异常
	 */
	public int uploadStats(java.lang.Long uploadId, String fileStats);

	/**
	 * 文件备注修改
	 * 
	 * @param uploadId	上传文件id
	 * @param remark	文件备注说明
	 * @param policeCode	接警编号
	 * @param policeTime	出警时间
	 * @param policeDesc	警情描述
	 * @param takeTime		录制时间
	 * @param useTime		接警时间-录制时间
	 * @param policeType	文件类型
	 * @return 0-成功； 1-失败 系统异常；
	 */
	public int uploadRemark(Long uploadId, String remark, String policeCode, String policeTime, String policeDesc, String takeTime, Long useTime, Long policeType);

	/**
	 * 文件删除（逻辑删除）
	 * 
	 * @param uploadList
	 * 			UploadForm.uploadId	需要删除的文件id
	 * @param deleteStats			false-保留重要；true-删除重要；
	 * @return 0-成功； 1-失败 系统异常；
	 */
	public int uploadDel(List<UploadForm> uploadList, boolean deleteStats);

	/**
	 * 文件加☆★筛选列表
	 * 
	 * @param uploadIdArr
	 * @return List
	 * 			list.get(0)-重要性文件list； list.get(1)-非重要性文件list；
	 */
	@SuppressWarnings("unchecked")
	public List uploadStatsList(String[] uploadIdArr);

	/**
	 * 文件查询
	 * 
	 * @param uploadName		文件名 模糊查询
	 * @param treeId			部门id
	 * @param parentTreeId		上级部门id
	 * @param beginTime			查询开始时间
	 * @param endTime			查询截止时间
	 * @param uploadUserId		文件上传人
	 * @param fileCreateUserId	采集人
	 * @param fileStats			文件重要性 1-重要
	 * @param fileRemark		备注说明
	 * @param takeTime			录制时间
	 * @param policeCode		接警编号
	 * @param policeTime		接警时间
	 * @param policeDesc		简要警情
	 * @param page
	 * 			pagecute 当前页 默认第1页
	 *			pageline 每页行数 默认10行
	 * @param showTree			文件所属部门
	 * @param checkNull			文件备注和处警内容为空
	 * @return
	 */
	public Page uploadListByTree(String uploadName, String treeId, String parentTreeId,
								String beginTime, String endTime, String uploadUserId,
								String fileCreateUserId, String fileStats, String fileRemark,
								String takeTime_begin, String takeTime_end, String policeCode,
								String policeTime_begin, String policeTime_end, String policeDesc,
								String useTime_begin, String useTime_end, Long policeType, Page page,
								String showTree, String nullRemark, String nullPoliceCode, String nullPoliceDesc,
								String nullPoliceTime);

	/**
	 * 管理员文件查询
	 * 
	 * @param uploadName		文件名 模糊查询
	 * @param treeId			部门id
	 * @param parentTreeId		上级部门id
	 * @param beginTime			查询开始时间
	 * @param endTime			查询截止时间
	 * @param uploadUserId		文件上传人
	 * @param fileCreateUserId	采集人
	 * @param fileStats			文件重要性 1-重要
	 * @param fileRemark		备注说明
	 * @param takeTime			录制时间
	 * @param policeCode		接警编号
	 * @param policeTime		接警时间
	 * @param useTime_begin		到达时间（起始）
	 * @param useTime_end		到达时间（结束）
	 * @param page
	 * 			pagecute 当前页 默认第1页
	 *			pageline 每页行数 默认10行
	 * @param showTree			文件所属部门
	 * @param checkNull			文件备注和处警内容为空
	 * @return
	 */
	public Page uploadListByAdmin(String uploadName, String treeId, String parentTreeId,
								String beginTime, String endTime, String uploadUserId,
								String fileCreateUserId, String fileStats, String fileRemark,
								String takeTime_begin, String takeTime_end, String policeCode,
								String policeTime_begin, String policeTime_end, String policeDesc,
								String useTime_begin, String useTime_end, Long policeType, Page page,
								String showTree, String nullRemark, String nullPoliceCode, String nullPoliceDesc,
								String nullPoliceTime);

	/**
	 * 上传列表数据统计
	 * 
	 * @param beginTime
	 * @param endTime
	 * @param treeId
	 * @param page
	 * @return
	 */
	public Page uploadListTable(String beginTime, String endTime, Long treeId, Page page);

	/**
	 * 我的上传列表
	 * 
	 * @param treeId		部门id
	 * @param parentTreeId	上级部门id
	 * @param uploadUserId	文件上传人id
	 * @param page
	 * 			pagecute 当前页 默认第1页
	 *			pageline 每页行数 默认10行
	 * @return
	 */
	public Page mineUploadList(String beginTime,String endTime,String fileRemark,String policeCode,
			String policeDesc,String nullRemark,String nullPoliceCode,String nullPoliceDesc,
			String treeId, String parentTreeId, String uploadUserId, Page page);

	/**
	 * 过期文件列表（系统预删除的过期文件，所以给出的均为非加星的文件）
	 * 
	 * @param expiredDays 过期天数
	 * @return
	 */
	public List<UploadForm> expiredSysDekList(int expiredDays);

	/**
	 * 过期文件列表
	 * 
	 * @param expired 过期日期yyyyMMdd
	 * @return
	 */
	public List<UploadForm> expiredUploadAllList(String expired);

	/**
	 * 获取文件上传类型
	 * @return
	 */
	public List<PoliceTypeForm> policeTypeAll();

	/**
	 * 20130417需求1.3
	 * 视频分类统计
	 * @param treeId
	 * @param beginTime
	 * @param endTime
	 * @param useTimeBegin
	 * @param useTimeEnd
	 * @param response
	 * @return
	 */
	public List<UploadForm> statistic(Long treeId, String beginTime, String endTime, String useTimeBegin, String useTimeEnd, String policeTimeBegin, String policeTimeEnd);

	/**
	 * 20130417需求1.8
	 * 110接处警比对
	 * @param uploadTime
	 * @param treeId
	 * @param policeType
	 * @return
	 */
	public List<UploadForm> contrast(String uploadTimeBegin, String uploadTimeEnd, String policeTimeBegin, String policeTimeEnd, Long treeId, Long policeType);

	public Page statisticDetail(Long treeId, Long typeId, String beginTime, String endTime, String useTimeBegin, String useTimeEnd,
			String policeTimeBegin, String policeTimeEnd, Page page);
}
