<div class="backupDBSection">
	<h3>
		<i class="fa fa-database"></i> Backup
	</h3>
	<hr>
	<a class="btn btn-primary btn-lg" ng-click="backupDatabase()"><i
		class="fa fa-database fa-lg"></i> Take Backup</a>
</div>

<div class="container-fluid restoreDBSection">
	<div class="row">
		<h3>
			<i class="fa fa-undo"></i> Restore
		</h3>
		<hr>
		<div>
			<h4 class="padded">Place your backup file in the Desktop and select the file from below.</h4>
		</div>
		<form name="restoreForm"
			ng-submit="restoreForm.$valid && restoreDatabase()">
			<input type="file" name="restoreBackup" required>
			<button class="btn btn-success btn-lg paddedRestoreDBBtn"
				type="submit">
				<i class="fa fa-undo fa-lg"></i> Restore Backup
			</button>
		</form>
	</div>
</div>