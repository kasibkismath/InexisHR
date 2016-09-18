<div class="row">
	<div class="col-sm-12 titleTPad">
			<span>
				<h3><i class="fa fa-pie-chart"></i> Task Allocation</h3>
			</span>
	</div>
	<div class="col-sm-12">
		<ul class="list-group">
			<li class="list-group-item col-sm-offset-9 col-sm-2 tile"
				ng-class="{'high-completion': taskCompletedPercent>=70,
					'medium-completion': (taskCompletedPercent>= 40 && taskCompletedPercent<70),
					'low-completion': taskCompletedPercent<40}">
				<h3>Completed Task: </h3>
				<h4 ng-cloak>{{taskCompletedPercent}}%</h4>
			</li>
		</ul>
	</div>
	<div class="col-sm-12 chart-container">
		<canvas id="pie" class="chart chart-pie" width="100" height="27"
  			chart-data="userHRLeadData" chart-labels="userHRLeadLabels"
  			chart-legend="true">
		</canvas>
	</div>
</div>