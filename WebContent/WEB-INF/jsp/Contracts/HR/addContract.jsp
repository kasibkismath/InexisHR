<div class="modal fade" tabindex="-1" role="dialog" id="addContractModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Contract</h4>
      </div>
      <div class="modal-body">
		<form name="addContractForm" class="form-horizontal"
			ng-submit="addContractForm.$valid && checkFileLengthResult === false && 
			uploadContracts(saveContractEmp, files)" 
			enctype="multipart/form-data">
			
			<div class="form-group">
				<div role="alert" class="alert alert-danger padded" 
					ng-show="addContractForm.employee.$error.required 
						&& addContractForm.employee.$dirty">
					<strong>Error!</strong> Employee is required, please select one.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-if="checkMaxFilesResult === true">
					<strong>Error!</strong> An employee can only have 3 contracts, delete some contracts and try again.
				</div>
				<div ng-if="saveContractEmp != undefined" style="color:blue; margin-bottom:20px">
					<span style="margin-left: 20px">
					No of contracts currently held : {{filesCount}}</span>
				</div>
				<label class="col-sm-2 control-label">Employee</label>
				<div class="col-sm-10">
					<select ng-model="saveContractEmp" name="employee" class="form-control"
						required
						ng-change="checkMaxFiles(saveContractEmp, files); 
						returnFilesCountByEmpId(saveContractEmp)">
						<option value="">Select an employee</option>
						<option value="{{employee.empId}}" 
						ng-repeat="employee in employees" 
						ng-hide="employee.designation.name == 'Ceo' || employee.status === false">
						{{employee.firstName}} {{employee.lastName}}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div ng-messages="addContractForm.file.$error" role="alert" 
					ng-if="addContractForm.file.$dirty">
					<div ng-message="pattern" class="alert alert-danger padded">
						<strong>Error!</strong> File should be PDF
					</div>
					<div ng-message="required" class="alert alert-danger padded">
						<strong>Error!</strong> File is required
					</div>
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-if="checkFileLengthResult === true">
					<strong>Error!</strong> Only 3 files can be selected.
				</div>
				<div role="alert" class="alert alert-danger padded" 
					ng-if="addContractForm.file.$error.maxSize">
					<strong>Error!</strong> A file can only be maximum of '5 MB' in size.
				</div>
				<label class="col-sm-2 control-label">File Upload</label>
				<div class="col-sm-10">
					<input type="file" ngf-select ng-model="files" name="file" ngf-pattern="'.pdf'"
   						ngf-accept="'application/*'" ngf-max-size="5MB"
   						multiple accept="application/*" 
   						required 
   						ng-change="checkFileLength(files); 
   						checkMaxFiles(saveContractEmp, files)">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label"></label>
				<div class="col-sm-10">
					<ul>
        				<li ng-repeat="f in files" style="font:smaller; margin-left:-25px;">
           				{{f.name}}
        				</li>
    				</ul>
				</div>
			</div>
	      	<div class="modal-footer">
	       		<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        	<button type="submit" class="btn btn-success">Save</button>
	      	</div>
      	</form>	
      </div>
    </div>
  </div>
</div>