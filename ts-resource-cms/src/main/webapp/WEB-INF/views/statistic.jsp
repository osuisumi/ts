<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript" src="${ctx }/js/library/echarts/build/dist/echarts.js"></script>
<div class="m-mod-tt">
	<h2 class="tt">
		<i class="u-tt-ico ico18"></i>应用统计
	</h2>
</div>
<div class="g-mod-dt1">
	<ul class="g-charts-box">
		<li class="item">
			<div class="m-charts-block">
				<div class="chart1" id="chartMain1"></div>
				<dl class="dlst">
					<dd>资源总量：${resourceNum } 个</dd>
					<dd>本月新增：${newResourceNum } 个</dd>
					<dd>共有学校： ${deptNum }所</dd>
					<dd>参与教师： ${teacherNum } 位教师</dd>
				</dl>
			</div>
		</li>
		<li class="item">
			<div class="m-charts-block">
				<div class="chart2" id="chartMain2"></div>
			</div>
		</li>
	</ul>
</div>
<script>
$(function(){
	 //百分比圆环
    annulusPercentage('${resourceNum}','${newResourceNum}','chartMain1');

    chartsCanvas2();
});

//百分比圆环 --echarts
function annulusPercentage(totalNum, newNum ,ids){
	var percentNum = newNum * 100 / totalNum;
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
                    color: 'rgba(229,229,229,1)',
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
            var radius = [62, 86];
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
                                    formatter : newNum+'+',

                                    textStyle: {
                                        baseline : 'center',
                                        fontWeight: "300",
                                        fontSize: "24",
                                        color: "#16a1e9",
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
                                name:'',
                                value: percentNum,
                                itemStyle :
                                {
                                    normal : {
                                         color: '#16a1e9',
                                        label : {
                                            show : true,
                                            position : 'center',
                                            formatter : '{b}',
                                            textStyle: {
                                                baseline : 'bottom',
                                                fontWeight: "300",
                                                fontSize: "14",
                                                color: '#e5e5e5'

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

function chartsCanvas2(){
    // 路径配置
    require.config({
        paths: {
            echarts: 'js/library/echarts-2.2.3/build/dist'
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
            var myChart = ec.init(document.getElementById("chartMain2"));
            option = {
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient : 'vertical',
                    x : 'left',
                    y : 'center',
                    data:['教师上传','编辑发布'],
                    textStyle : {
                        fontSize: "14",
                        fontFamily: "微软雅黑",
                        color: "#6b6b70"

                    }
                },
                toolbox: {
                    show : false
                },
                calculable : false,
                series : [
                    {
                        name:'资源来源',
                        type:'pie',
                        radius : ['62%', '86%'],
                        itemStyle : {
                            normal : {
                                color:function(program){
                                    var colorlist=['#16a1e9','#55c760','#dcbb35'];
                                    return colorlist[program.dataIndex]
                                },
                                label : {
                                    show : false
                                },
                                labelLine : {
                                    show : false
                                }
                            },
                            emphasis : {
                                label : {
                                    show : true,
                                    position : 'center',
                                    textStyle : {
                                        fontSize : '20',
                                        fontWeight : 'bold'
                                    }
                                }
                            }
                        },
                        data:[
                            {value:'${teacherResourceNum}', name:'教师上传'},
                            {value:'${editorResourceNum}', name:'编辑发布'}
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