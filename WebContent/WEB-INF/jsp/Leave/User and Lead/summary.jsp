<div class="row">
	<div class="col-sm-12 appraisalChartTitle">
			<span>
				<h3><i class="fa fa-pie-chart"></i> Leaves Summary</h3>
			</span>
	</div>
	<div>
		<ul class="list-group">
			<li class="list-group-item col-md-offset-9 col-md-2 leaveAvailability">
				<h3>Leaves Available: </h3>
				<h4> <span ng-class="{'alert-danger': availableLeaves < 5, 
					'alert-warning': availableLeaves <= 10, 'alert-success': availableLeaves <= 15}">
					{{availableLeaves}} days</span>
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