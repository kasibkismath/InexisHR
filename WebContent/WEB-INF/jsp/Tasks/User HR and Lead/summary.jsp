<div class="row">
	<div class="col-sm-12">
		<ul class="list-group">
			<li class="list-group-item list-group-item-warning col-md-2 pendingTasksTile">
				<h3>Pending: </h3>
				<h4>{{getPendingTaskCountResult}} Tasks</h4>
			</li>
			<li class="list-group-item list-group-item-danger col-md-2 overdueTasksTile">
				<h3>Overdue: </h3>
				<h4>
					{{getOverdueTaskCountResult}} Tasks
				</h4>
			</li>
			<li class="list-group-item col-md-2 onHoldTasksTile">
				<h3>On-Hold: </h3>
				<h4>
					{{getOnHoldTaskCountResult}} Tasks
				</h4>
			</li>
			<li class="list-group-item list-group-item-success col-md-2 completedTasksTile">
				<h3>Completed: </h3>
				<h4>
					{{getCompletedTaskCountResult}} Tasks
				</h4>
			</li>
			<li class="list-group-item col-md-2 terminatedTasksTile">
				<h3>Terminated: </h3>
				<h4>
					{{getTerminatedTaskCountResult}} Tasks
				</h4>
			</li>
		</ul>
	</div>
	<div class="col-sm-12 titleTPad">
			<span>
				<h3><i class="fa fa-bar-chart"></i> Task Completion Percentage</h3>
			</span>
	</div>
	<div class="col-sm-12 chart-container">
		<canvas id=bar class="chart chart-bar" width="100" height="25"
  			chart-data="leadCeoData" chart-labels="leadCeoLabels">
		</canvas>
	</div>
</div>