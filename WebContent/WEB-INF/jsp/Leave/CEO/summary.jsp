<div class="row">
	<div class="col-sm-12 appraisalChartTitle">
			<span>
				<h3><i class="fa fa-pie-chart"></i> Leaves Taken Summary (In Days)</h3>
			</span>
	</div>
	<div>
		<ul class="list-group">
			<li class="list-group-item col-md-offset-7 col-md-2 leavePending">
				<h3>Leaves Pending: </h3>
				<h4> <span ng-cloak ng-class="{'alert-success': sumOfPendingLeaves < 5, 
					'alert-warning': sumOfPendingLeaves >= 5, 'alert-danger': sumOfPendingLeaves >= 15}">
					{{sumOfPendingLeaves}} days</span>
				</h4>
			</li>
			<li class="list-group-item col-md-2 leaveAvailability">
				<h3>Leaves Available: </h3>
				<h4> <span ng-cloak ng-class="{'alert-danger': availableLeaves < 5, 
					'alert-warning': availableLeaves <= 10, 'alert-success': availableLeaves <= 21}">
					{{availableLeaves}} days</span>
				</h4>
			</li>
		</ul>
	</div>
	<div style="padding-top: 30px;"class="col-sm-12 chart-container">
		<canvas id="bar" class="chart chart-bar" width="100" height="25"
  			chart-data="ceoData" chart-labels="ceoLabels" chart-series="ceoSeries"
  			chart-legend="true">
		</canvas>	
	</div>
</div>