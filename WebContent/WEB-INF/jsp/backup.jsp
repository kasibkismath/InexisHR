<div class="backupDBSection">
	<h4><i class="fa fa-database"></i> Backup</h4>
	<hr>
	<a class="btn btn-primary btn-lg" ng-click="backupDatabase()"><i class="fa fa-database fa-lg"></i> Take
		Backup</a>
</div>

<div class="container restoreDBSection">
	<div class="row">
		<h4><i class="fa fa-undo"></i> Restore</h4>
		<hr>
		<form ng-submit="restoreDatabase()">
			<input type="file" name="restoreDB" nv-file-select uploader="uploader">
			<button class="btn btn-success btn-lg paddedRestoreDBBtn" type="submit"><i class="fa fa-undo fa-lg"></i> Restore
				Database</button>
		</form>
	</div>
</div>