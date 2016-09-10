<div class="row">
	<div class="col-sm-12">
			<span>
				<h3><i class="fa fa-pie-chart"></i> Attendance Summary </h3>
			</span>
	</div>
	<div>
		<ul class="list-group">
			<li class="list-group-item col-md-offset-7 col-md-2 dailyHoursTile">
				<h3>Daily Hours: </h3>
				<h4> <span ng-cloak ng-class="{'alert-success': sumOfPendingLeaves < 5, 
					'alert-warning': sumOfPendingLeaves >= 5, 'alert-danger': sumOfPendingLeaves >= 15}">
					{{sumOfPendingLeaves}} hours</span>
				</h4>
			</li>
			<li class="list-group-item col-md-2 weeklyHoursTile">
				<h3>Weekly Hours: </h3>
				<h4> <span ng-cloak ng-class="{'alert-danger': availableLeaves < 5, 
					'alert-warning': availableLeaves <= 10, 'alert-success': availableLeaves <= 21}">
					{{availableLeaves}} hours</span>
				</h4>
			</li>
		</ul>
	</div>
	<div class="col-sm-12 chart-container">
		<canvas id="pie" class="chart chart-pie" width="100" height="27"
  			chart-data="userAndLeadData" chart-labels="userAndLeadLabel"
  			chart-legend="true">
		</canvas>
	</div>
</div>