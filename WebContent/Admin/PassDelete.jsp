<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>

<div id="parah"></div>
	<script>
		var arrInput = new Array(0);
		var arrInputValue = new Array(0);
		 
		function addInput() {
		  arrInput.push(arrInput.length);
		  arrInputValue.push("");
		  display();
		}
		 
		function display() {
		  document.getElementById('parah').innerHTML="";
		  for (intI=0;intI<arrInput.length;intI++) {
		    document.getElementById('parah').innerHTML+=createInput(arrInput[intI], arrInputValue[intI]);
		  }
		}
		 
		function saveValue(intId,strValue) {
		  arrInputValue[intId]=strValue;
		  	  
		}  
		 
		function createInput(id,value) {
			
			var titile;
			
			if(id%2 == 0){
				title = "질문";
			}
			else {
				title = "대답";
			}
			
			return "<label >"+ title + "<span>*</span></label>" +
			"<div >" +
			"<textarea id='text" + id + "' onChange='javascript:saveValue(" + id + ",this.value)' value='" + value + "'></textarea>" +
			"</div>";}
		 
		function deleteInput() {
		  if (arrInput.length > 0) { 
		     arrInput.pop(); 
		     arrInputValue.pop();
		  }
		  display(); 
		}
	</script>



<div id="textContent" style="display:none">
	<div class="form-group" >
		<label class="control-label col-md-3 col-sm-3 col-xs-12">질문<span class="required">*</span></label>
		<div class="col-md-9 col-sm-9 col-xs-12">
			<textarea class="form-control" rows="2" placeholder="rows=&quot;3&quot;"></textarea>
		</div>
	</div>
	<div class="form-group" >
		<label class="control-label col-md-3 col-sm-3 col-xs-12">내용<span class="required">*</span></label>
		<div class="col-md-9 col-sm-9 col-xs-12">
			<textarea class="form-control" rows="10" placeholder="rows=&quot;10&quot;"></textarea>
		</div>
	</div>
	<div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
		<button  class="btn btn-dark" onclick="remove_item(this)"> 삭제</button>
	</div>
</div>





<form method="post" action="test.jsp">
<input type="button" value="추가" onclick="addInput();" />
<input type="button" value="삭제" onclick="deleteInput();"/>
<input type="submit" value="전송"/>
</form>
<!-- ------------------------------------------------------------------ -->


	<script>
	    function add_item(){
	        // pre_set 에 있는 내용을 읽어와서 처리..
	        var div = document.createElement('div');
	        div.innerHTML = document.getElementById('pre_set').innerHTML;
	        document.getElementById('field').appendChild(div);
	    }
	 
	    function remove_item(obj){
	        // obj.parentNode 를 이용하여 삭제
	        document.getElementById('field').removeChild(obj.parentNode);
	    }
	</script>

</head>


<body>

<div id="pre_set" style="display:none">
    <input type="text" name="" value="" style="width:200px"> 
    <input type="button" value="삭제" onclick="remove_item(this)">
</div>
 
<div id="field"></div>
 
<input type="button" value=" 추가 " onclick="add_item()"><br>
추가 버튼을 눌러보세요.

</body>
</html>