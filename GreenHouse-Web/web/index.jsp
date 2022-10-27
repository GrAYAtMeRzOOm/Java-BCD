<%-- 
    Document   : index
    Created on : Jul 20, 2022, 5:42:42 PM
    Author     : grays
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GreenHouse-DashBoard</title>

        <link rel="icon" type="image/x-icon" href="img/favicon.ico">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">

        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">

        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <link rel="stylesheet" type="text/css" href="apex/apexcharts.css">

        <link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">

        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">

    </head>
    <body>
        <div style="padding: 10px;" class="container">

            <h1 style="padding: 20px;"class="d-flex bg-success text-white justify-content-center"><img src="img/logo.png" style="margin-right: 25px;" width="50" height="50" alt="Logo image"/>  Green House Dashboard</h1>
        </div>
        <div class="container-lg">
            <div class="card-deck">
                <div class="card border-light mb-3" style="max-width: 18rem;">
                    <div class="card-header">Temperature</div>
                    <div class="card-body">
                        <div id="chart-temp">

                        </div>
                    </div>
                </div>
                <div class="card border-light mb-3" style="max-width: 18rem;">
                    <div class="card-header">Humidity</div>
                    <div class="card-body">
                        <div id="chart-hum">

                        </div>
                    </div>
                </div>
                <div class="card border-light mb-3" style="max-width: 18rem;">
                    <div class="card-header">Moisture</div>
                    <div class="card-body">
                        <div id="chart-moi">

                        </div>
                    </div>
                </div>
                <div class="card border-light mb-3" style="max-width: 18rem;">
                    <div class="card-header">Light</div>
                    <div class="card-body">
                        <div id="chart-lig">

                        </div>
                    </div>
                </div>
            </div>
            <div class="container-lg">
                <div style="padding: 10px;" id="mainChart">

                </div>
            </div>
            <div style="padding: 10px;" class="container-lg">
                <div class="d-flex justify-content-center">
                    <div class="wrap-table100">
                        <div class="table100 ver1 m-b-110">
                            <div class="table100-head">
                                <table>
                                    <thead>
                                        <tr class="row100 head">
                                            <th class="cell100 column1">Time</th>
                                            <th class="cell100 column2">Temperature</th>
                                            <th class="cell100 column3">Humidity</th>
                                            <th class="cell100 column4">Moisture</th>
                                            <th class="cell100 column5">Light</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                            <div class="table100-body js-pscroll">
                                <table>
                                    <tbody id="tableView">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </body>
    <script src="vendor/jquery/jquery-3.2.1.min.js"></script>

    <script src="vendor/bootstrap/js/popper.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

    <script src="vendor/select2/select2.min.js"></script>
    <script src="apex/apexcharts.amd.js"></script>
    <script src="apex/apexcharts.js"></script>
    <script src="apex/apexcharts.min.js"></script>

    <script src="vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script>
        $('.js-pscroll').each(function run() {
            var ps = new PerfectScrollbar(this);
            $(window).on('resize', function () {
                ps.update();
            });
        });

        var temp = 0;
        var moi = 0;
        var hum = 0;
        var lig = 0;
        var tempAr = [];
        var moiAr = [];
        var humAr = [];
        var ligAr = [];
        var timeAr = [];
        var f1 = function loadTable() {
            $.ajax({
                url: "getData",
                dataType: 'json',
                success: function (data) {
                    let val;
                    $.each(data, function (key, value) {
                        val += '<tr class="row100 body"><td class="cell100 column1" >' + value.timestamp + '</td>';
                        val += '<td class="cell100 column2" >' + value.temperature + '</td>';
                        val += '<td class="cell100 column3" >' + value.humidity + '</td>';
                        val += '<td class="cell100 column4" >' + value.moisture + '</td>';
                        val += '<td class="cell100 column5" >' + value.light + '</td></tr>';

                        temp = value.temperature;
                        hum = value.humidity;
                        moi = value.moisture;
                        lig = value.light;

                        tempAr.push(value.temperature);
                        humAr.push(value.humidity);
                        moiAr.push(value.moisture);
                        ligAr.push(value.light);
                        timeAr.push(value.timestamp);
                    });
                    $('#tableView').html(val);
                    console.log(temp);
                }
            });

            chart1.updateSeries([lig], true);
            chart2.updateSeries([temp], true);
            chart3.updateSeries([hum], true);
            chart4.updateSeries([moi], true);
            chartMain.updateSeries([{
                    name: 'Temperature',
                    data: tempAr
                }, {
                    name: 'Humidity',
                    data: humAr
                }, {
                    name: 'Moisture',
                    data: moiAr
                }, {
                    name: 'Light',
                    data: ligAr
                }
            ], true);

            chartMain.resetSeries(true, true);data

        };
        setInterval(f1, 5000);

        var options1 = {
            chart: {
                height: 280,
                type: "radialBar"
            },
            series: [lig],
            colors: ["#20E647"],
            plotOptions: {
                radialBar: {
                    hollow: {
                        margin: 0,
                        size: "70%",
                        background: "#293450"
                    },
                    track: {
                        dropShadow: {
                            enabled: true,
                            top: 2,
                            left: 0,
                            blur: 4,
                            opacity: 0.15
                        }
                    },
                    dataLabels: {
                        name: {
                            offsetY: -10,
                            color: "#fff",
                            fontSize: "13px"
                        },
                        value: {
                            color: "#fff",
                            fontSize: "30px",
                            show: true,
                            formatter: function (val) {
                                return val + ' %';
                            }
                        }
                    }
                }
            },
            fill: {
                type: "gradient",
                gradient: {
                    shade: "dark",
                    type: "vertical",
                    gradientToColors: ["#87D4F9"],
                    stops: [0, 100]
                }
            },
            stroke: {
                lineCap: "round"
            },
            labels: ["Light"]
        };

        var chart1 = new ApexCharts(document.querySelector("#chart-lig"), options1);

        chart1.render();

        var options2 = {
            chart: {
                height: 280,
                type: "radialBar"
            },
            series: [temp],
            colors: ["#20E647"],
            plotOptions: {
                radialBar: {
                    hollow: {
                        margin: 0,
                        size: "70%",
                        background: "#293450"
                    },
                    track: {
                        dropShadow: {
                            enabled: true,
                            top: 2,
                            left: 0,
                            blur: 4,
                            opacity: 0.15
                        }
                    },
                    dataLabels: {
                        name: {
                            offsetY: -10,
                            color: "#fff",
                            fontSize: "13px"
                        },
                        value: {
                            color: "#fff",
                            fontSize: "30px",
                            show: true,
                            formatter: function (val) {
                                return val + ' ℃';
                            }
                        }
                    }
                }
            },
            fill: {
                type: "gradient",
                gradient: {
                    shade: "dark",
                    type: "vertical",
                    gradientToColors: ["#87D4F9"],
                    stops: [0, 100]
                }
            },
            stroke: {
                lineCap: "round"
            },
            labels: ["Temperature"]
        };

        var chart2 = new ApexCharts(document.querySelector("#chart-temp"), options2);

        chart2.render();

        var options3 = {
            chart: {
                height: 280,
                type: "radialBar"
            },
            series: [hum],
            colors: ["#20E647"],
            plotOptions: {
                radialBar: {
                    hollow: {
                        margin: 0,
                        size: "70%",
                        background: "#293450"
                    },
                    track: {
                        dropShadow: {
                            enabled: true,
                            top: 2,
                            left: 0,
                            blur: 4,
                            opacity: 0.15
                        }
                    },
                    dataLabels: {
                        name: {
                            offsetY: -10,
                            color: "#fff",
                            fontSize: "13px"
                        },
                        value: {
                            color: "#fff",
                            fontSize: "30px",
                            show: true,
                            formatter: function (val) {
                                return val;
                            }
                        }
                    }
                }
            },
            fill: {
                type: "gradient",
                gradient: {
                    shade: "dark",
                    type: "vertical",
                    gradientToColors: ["#87D4F9"],
                    stops: [0, 100]
                }
            },
            stroke: {
                lineCap: "round"
            },
            labels: ["Humidity"]
        };

        var chart3 = new ApexCharts(document.querySelector("#chart-hum"), options3);

        chart3.render();

        var options4 = {
            chart: {
                height: 280,
                type: "radialBar"
            },
            series: [moi],
            colors: ["#20E647"],
            plotOptions: {
                radialBar: {
                    hollow: {
                        margin: 0,
                        size: "70%",
                        background: "#293450"
                    },
                    track: {
                        dropShadow: {
                            enabled: true,
                            top: 2,
                            left: 0,
                            blur: 4,
                            opacity: 0.15
                        }
                    },
                    dataLabels: {
                        name: {
                            offsetY: -10,
                            color: "#fff",
                            fontSize: "13px"
                        },
                        value: {
                            color: "#fff",
                            fontSize: "30px",
                            show: true,
                            formatter: function (val) {
                                return val + ' ';
                            }
                        }
                    }
                }
            },
            fill: {
                type: "gradient",
                gradient: {
                    shade: "dark",
                    type: "vertical",
                    gradientToColors: ["#87D4F9"],
                    stops: [0, 100]
                }
            },
            stroke: {
                lineCap: "round"
            },
            labels: ["Moisture"]
        };

        var chart4 = new ApexCharts(document.querySelector("#chart-moi"), options4);

        chart4.render();

        var mainChart = {
            chart: {
                height: 350,
                type: 'area',
                stacked: true,
                toolbar: {
                    show: true
                }
            },
            dataLabels: {
                enabled: true
            },
            stroke: {
                curve: 'smooth'
            },
            series: [{
                    name: 'Temperature',
                    data: tempAr
                }, {
                    name: 'Humidity',
                    data: humAr
                }, {
                    name: 'Moisture',
                    data: moiAr
                }, {
                    name: 'Light',
                    data: ligAr
                }
            ],

            xaxis: {
                type: 'datetime',
                categories: timeAr
            },
            tooltip: {
                x: {
                    format: 'dd/MM/yy HH:mm'
                }
            }
        };

        var chartMain = new ApexCharts(document.querySelector("#mainChart"), mainChart);
        chartMain.render();

    </script>
</html>
