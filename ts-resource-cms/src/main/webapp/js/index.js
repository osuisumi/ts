function downloadExcel(fileName){
	$('#downloadExcelForm input[name="fileName"]').val(fileName);
	$('#downloadExcelForm').submit();
}