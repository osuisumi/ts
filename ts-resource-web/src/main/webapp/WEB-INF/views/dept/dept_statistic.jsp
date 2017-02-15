<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<style>
table{font-size: 12px;}
</style>
<script type="text/javascript" src="${ctx }/js/library/echarts/build/dist/echarts.js"></script>
<div class="g-rsc-stat">
	<div class="m-stat-chart">
		<h3 class="tt">应用统计</h3>
		<div class="chart" id="chartMain"></div>
		<p>
			<span>资源总量：<strong>${deptStatistic.resourceNum }</strong>个
			</span>
		</p>
		<p>
			<span>本月新增：<strong>${deptStatistic.newResourceNum }</strong>个
			</span>
		</p>
		<div class="line"></div>
		<p>
			<span>已有<strong>${deptStatistic.teacherNum }</strong>位老师开通空间
			</span>
		</p>
		<p>
			<span>发现<strong>${deptStatistic.discoveryNum }</strong>个教学新思路
			</span>
		</p>
	</div>
	<div class="m-stat-rank">
		<h3 class="tt">学校资源应用排行榜TOP10</h3>
		<table cellpadding="0" cellspacing="0" border="0" class="g-stat-table">
			<thead>
				<tr>
					<th>学校</th>
					<th>上传总量</th>
					<th style="border: 0">下载总量</th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<!-- <td colspan="3" style="border: 0"><a href="school/school-lst.html" class="more">更多&gt;</a></td> -->
				</tr>
			</tfoot>
			<tbody>
				<c:forEach items="${deptStatistic.departmentInfos }" var="dept">
					<tr>
						<td><a onclick="viewDept('${dept.id }')">${dept.deptName }</a></td>
						<td>${dept.uploadNum }</td>
						<td style="border: 0">${dept.downloadNum }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<input id="percent" type="hidden" value=''>
<fmt:formatNumber value="${deptStatistic.newResourceNum * 100 / deptStatistic.resourceNum }" var="percent" pattern="##"  />
<script type="text/javascript">
$(function(){
    resourceChart('${percent}',"chartMain", '${deptStatistic.newResourceNum}', '${deptStatistic.resourceNum}');

});

function goSchool(url){
	if(url != null && url != ''){
		window.open(url);
	}else{
		alert('此学校还未设置链接网站');
	}
}

//百分比圆环 --echarts
function resourceChart(percentNum,ids, newNum, totalNum){
    // 路径配置
    require.config({
        paths: {
            echarts: 'js/library/echarts/build/dist'
        }
    });
    // 使用
    require(
        [
            'echarts',
            'echarts/chart/pie' // 使用柱状图就加载bar模块，按需加载
        ],
        function (ec) {
            // 基于准备好的dom，初始化echarts图表
            var myChart = ec.init(document.getElementById(ids));

            var percentText = percentNum;
            /*if(percentNum == 0) {
                percentNum = 0;
            }
*/
            var labelTop = {
                normal : {
                    label : {
                        show : true,
                        position : 'center',
                        formatter : '{b}',
                        textStyle: {
                            baseline : 'bottom',
                            fontWeight: "700",
                            fontSize: "14",
                            color: "#ff8800"
                        }
                    },
                    labelLine : {
                        show : false
                    }
                }
            };
            var labelFromatter = {
                normal : {
                    label : {
                        /*formatter : function (params){
                            return 100 - params.value + "%"
                        },*/
                        formatter : '208',

                        textStyle: {
                            baseline : 'top',
                            fontWeight: "700",
                            fontSize: "14",
                            color: "#333",
                            fontFamily: "微软雅黑"
                        }
                    }
                },
            }
            var labelBottom = {
                normal : {
                    color: 'rgba(0,0,0,0.12)',
                    label : {
                        show : true,
                        position : 'center'
                    },
                    labelLine : {
                        show : false
                    }

                },
                emphasis: {
                    color: 'rgba(0,0,0,0)'
                }
            };
            var radius = [56, 66];
            option = {
                /*legend: {
                    show: false,
                    x : 'center',
                    y : 'bottom',
                    //isSelected : false,
                    data:['课程学习'],
                    backgroundColor : 'rgba(0,0,0,0)',
                   // padding : '5px',
                    textStyle : {
                        color: "#fff",
                        fontSize: "14",
                        fontFamily: "微软雅黑"

                    }
                },*/
                series : [
                    {
                        type : 'pie',
                        center : ['50%', '50%'],
                        radius : radius,
                        x: '0%', // for funnel
                        itemStyle : {
                            normal : {
                                label : {
                                    /*formatter : function (params){
                                        return 100 - params.value + "%"
                                    },*/
                                    formatter : totalNum,

                                    textStyle: {
                                        baseline : 'top',
                                        fontWeight: "700",
                                        fontSize: "14",
                                        color: "#fff",
                                        fontFamily: "微软雅黑"
                                    }
                                }
                            },
                        },
                        data : [
                            {
                                name:'other',
                                value: 100 - percentNum,
                                itemStyle : labelBottom
                            },
                            {
                                name:'+'+newNum,
                                value: percentNum,
                                itemStyle :
                                {
                                    normal : {
                                         color: '#ffe614',
                                        label : {
                                            show : true,
                                            position : 'center',
                                            formatter : '{b}',
                                            textStyle: {
                                                baseline : 'bottom',
                                                fontWeight: "700",
                                                fontSize: "20",
                                                color: '#ffe614'

                                            }
                                        },
                                        labelLine : {
                                            show : false
                                        }
                                    }
                                }

                            }
                        ]
                    }
                ]
            };
            // 为echarts对象加载数据
            myChart.setOption(option);
        }
    );
}
</script>