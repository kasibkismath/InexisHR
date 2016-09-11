<div class="row">
	<div class="col-sm-12">
			<span>
				<h3><i class="fa fa-pie-chart"></i> Weekly Hours By Project </h3>
			</span>
	</div>
	<div>
		<ul class="list-group">
			<li class="list-group-item col-md-offset-7 col-md-2 dailyHoursTile">
				<h3>Daily Hours: </h3>
				<h4>{{dailyHours}} hours</h4>
			</li>
			<li class="list-group-item col-md-2 weeklyHoursTile">
				<h3>Weekly Hours: </h3>
				<h4>
					{{weeklyHours}} hours
				</h4>
			</li>
		</ul>
	</div>
	<div class="col-sm-12 chart-container">
		<canvas id="pie" class="chart chart-pie" width="100" height="27"
  			chart-data="userLeadHrData" chart-labels="userLeadHrLabel"
  			chart-legend="true">
		</canvas>
	</div>
</div>