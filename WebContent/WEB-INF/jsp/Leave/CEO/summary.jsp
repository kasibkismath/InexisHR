<div class="row">
	<div class="col-sm-12 appraisalChartTitle">
			<span>
				<h3><i class="fa fa-bar-chart"></i> Leaves Taken Summary (In Days)</h3>
			</span>
	</div>
	<div>
		<ul class="list-group">
			<li class="list-group-item col-md-offset-9 col-md-2 pendingRequests">
				<h3>Pending Requests: </h3>
				<h4> <span ng-cloak ng-class="{'alert-success': sumOfPendingLeavesForCEO <= 5, 
					'alert-warning': sumOfPendingLeavesForCEO > 5, 'alert-danger': sumOfPendingLeavesForCEO > 11}">
					{{sumOfPendingLeavesForCEO}} </span>
				</h4>
			</li>
		</ul>
	</div>
	<div style="padding-top: 30px;" class="col-sm-12 chart-container">
		<canvas id="bar" class="chart chart-bar" width="100" height="25"
  			chart-data="ceoData" chart-labels="ceoLabels" chart-series="ceoSeries"
  			chart-legend="true">
		</canvas>	
	</div>
</div>