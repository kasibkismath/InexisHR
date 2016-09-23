<div class="row">
	<div class="col-sm-12 titleTPad">
			<span>
				<h3><i class="fa fa-pie-chart"></i> Applicant Leads</h3>
			</span>
	</div>
	<div class="col-sm-12">
		<ul class="list-group">
			<li class="list-group-item list-group-item-danger col-md-offset-9 col-md-2 expiredVacancies">
				<h3>Expired Vacancies: </h3>
				<h4>{{expiredVacanciesCountResult}}</h4>
			</li>
		</ul>
	</div>
	<div class="col-sm-12 chart-container">
		<canvas id="pie" class="chart chart-pie" width="100" height="26"
  			chart-data="applicantLeadData" chart-labels="applicantLeadLabels"
  			chart-legend="true">
		</canvas>
	</div>
</div>