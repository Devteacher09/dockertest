<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<section>
	<h2>ajax로 서버에 요청 보내기!</h2>
	<h3>기본 XMLHttpRequest객체를 활용</h3>
	<p>
		XMLHttpRequest객체를 javascript에서 제공함.<br>
		XMLHttpRequest객체를 생성, 설정해서 서버에 요청을 보낼 수 있음<br>
		객체 속성설정하기<br>
		onreadystatechange : 요청상태가 변경될때 마다 실행되는 callback함수를 설정 -> 서버의 응답이 완료되면 처리할 로직을 작성<br>
		 readyState : 요청상태를 저장하는 속성 0 ~ 4<br>
		 status : response status값을 저장하는 속성<br>
		 404, 403, 200, 500, 302<br>
		 readySatate==4 / status==200 응답 정상처리<br>
		 responseText : 응답한 데이터를 저장하는 속성<br>

		사용하는 함수<br>
		open("method","url") : 요청방식(GET,POST,PUT,DELETE)과, 요청주소(URL)를 설정하는 함수<br>
		send(["data"]) : 요청을 전송하는 함수<br>
	</p>
	<button onclick="basicRequest();">기본요청</button>
	<div id="container"></div>


	<script>
		const basicRequest=()=>{
			//객체 생성
			const request=new XMLHttpRequest();
			//callback함수 등록하기
			request.onreadystatechange=()=>{
				//요청 상태가 변경될때마다 실행됨.
				console.log(request.readyState);
				console.log(request.status);
				console.log(request.responseText);
				if(request.readyState==4){
					document.querySelector("#container").innerHTML+=request.responseText;
				}
			}
			
			//요청정보설정
			request.open("get",'<%=request.getContextPath()%>/ajax/basicrequest.do?name=유병승');

			//요청보내기
			request.send();
		}
	</script>

	<h3>javascript제공하는 함수이용하기</h3>
	<p>
		fetch()함수 -> Promise객체로 처리<br>
		fetch('요청주소',{요청정보설정(메소드,body데이터,header)})
		.then(response=>{ return 응답데이터})
		.then(data=>{페이지 구성 로직})	

		const response=await fetch("url");
		const data=await response.text()||response.json();
		//반환된 data를 가지고 페이지 구성
		document.querySelector().innerHTML=data;
	</p>
	<button onclick="fetchTest()">fetch함수로 요청</button>
	<button onclick="fetchPost()">fetch함수 post</button>
	<div id="container2"></div>
	<script>
		const fetchPost=async ()=>{
			const response=await fetch('<%=request.getContextPath()%>/ajax/basicrequest.do',{
				method:"post",
				headers:{
					//application/x-www-form-urlencoded
					"Content-type":"application/json",
				},
				body:JSON.stringify({"name":"유병승","age":19,"gender":"M"})
			});
			if(response.ok){
				const data=await response.text();
				document.querySelector("#container2").innerText+=data;
			}
			
		}
		const fetchTest=()=>{
			fetch('<%=request.getContextPath()%>/ajax/basicrequest.do?name=jms')
			.then(response=>{
				console.log(response);
				if(response.ok){
					//body에 저장된 데이터를 반환
					//text() : body에 있는 데이터를 문자열로 반환
					//json() : body에 있는 데이터를 json(js객체)로 반환
					return response.text();
				}else{
					throw new Error('잘못된 요청입니다.');
				}
			}).then(data=>{
				console.log(data);
				const $h4=document.createElement("h4");
				$h4.innerText=data;
				document.querySelector("#container2").appendChild($h4);
			}).catch(e=>{
				alert(e);
			});

		}
	</script>
	
	<h3>jquery가 제공하는 함수이용</h3>
	<p>
		$.ajax({객체}) : 요청에 대한 상세설정을 할때 사용, header,content설정할때<br>
		$.get("url",콜백함수) : 기본 get으로 요청할때 -> 조회문<br>
		$.post("url",{data},콜백함수) : 기본 post로 요청할때 <br>
	</p>
	
	<h3>$.ajax함수이용</h3>
	<p>
		매개변수 객체의 속성이 정해져있음<br>
		url : 요청주소 -> String<br>
		[type] : 요청방식(GET,POST,PUT,DELETE) -> String default GET<br>
		[data] : 요청할때 보낼 데이터(parameter) -> Object/{key:value} <br>
		success : 응답이 완료됐을때 실행될 함수 -> function(data){}<br>
		[error] : 응답이 에러났을대 실행될 함수 -> function(response){} <br>
		[complete] : 요청의 성공,실패와 상관없이 실행된 로직을 작성 -> function(){}<br>
	</p>
	<button onclick="ajaxTest();">$.ajax이용하기</button>
	<input type="text" id="userName" placeholder="이름입력">
	<input type="number" id="age" placeholder="나이">
	<input type="text" id="gender" placeholder="성별">

	<div id="result"></div>
	<script>
		const ajaxTest=()=>{
			$.ajax({
				url:"<%=request.getContextPath()%>/ajax/jqueryajax1.do",
				type:"post",
				data:{"name":$("#userName").val(),
					"age":$("#age").val(),
					"gender":$("#gender").val()},
				success : data=>{
					console.log(data);
				},
				error:(response)=>{
					console.log(response);
					switch(response.status){
						case 404 : alert('페이지를 찾을 수 없습니다.!');break;
						case 500 : alert("서버관리자에게 문의하세요!");break;
					}
				},
				complete:()=>{
					console.log('complete실행');
				}
			});
		}
	</script>

	<h3>$.get() / $.post()</h3>
	<button id="btn">$.get()함수 이용</button>
	<button id="btn1">$.post()함수 이용</button>
	<div id="result2"></div>
	<script>
		$("#btn").click(e=>{
			<%-- $.get("<%=request.getContextPath()%>/ajax/jqueryajax.do?name=jms&age=27&gender=F",
					data=>{
						document.getElementById("result2").innerHTML=data;
					}); --%>
			$.get("<%=request.getContextPath()%>/ajax/jqueryajax1.do?name=jms&age=27&gender=F")
			.done(data=>{
				document.getElementById("result2").innerHTML=data;
			})
			.fail(response=>{
				console.log(response);
			});
		})
		$("#btn1").click(e=>{
			$.post("<%=request.getContextPath()%>/ajax/jqueryajax.do",{"name":"윤우식","age":27,"gender":"M"})
			.done(data=>{
				console.log(data);
			});
		});
	</script>

	<h3>서버에 있는 텍스트문서 가져오기</h3>
	<button	id="txtBtn">텍스트문서가져오기</button>
	<button id="csvBtn">csv데이터 가져오기</button>
	<div id="result3"></div>
	<script>
		$("#csvBtn").click(e=>{
			$.get("<%=request.getContextPath()%>/resources/cities.csv")
			.done(data=>{
				console.log(data);
				const rows=data.split("\n");
				const $table=document.createElement("table");
				rows.forEach(v=>{
					const columnValue=v.split(",");
					
					const $tr=columnValue.reduce((init,next)=>{
						const $td=document.createElement("td");
						$td.innerText=next;
						init.appendChild($td);
						return init;
					},document.createElement("tr"));
					
					$table.appendChild($tr);
				});
				
				document.getElementById("result3").innerHTML="";
				document.getElementById("result3").appendChild($table);
				
			});
		});
		$("#txtBtn").click(e=>{
			$.ajax({
				url:"<%=request.getContextPath()%>/resources/test.txt",
				success:data=>{
					console.log(data);
					const dataArr=data.split("\r\n");
					const $ul=dataArr.reduce((init,next)=>{
						const $li=document.createElement("li");
						$li.innerText=next;
						init.appendChild($li);
						return init;
					},document.createElement("ul"));
					console.log($ul);
					document.getElementById("result3").innerHTML="";
					document.getElementById("result3").appendChild($ul);
				}
			});
		});
	</script>
	<h4>서버에서 csv로 응답하기</h4>
	<button id="memberSearchBtn">회원조회</button>
	<div id="member-container"></div>
	<script>
		$("#memberSearchBtn").click(e=>{
			fetch("<%=request.getContextPath()%>/ajax/memberlist.do")
			.then(response=>response.text())
			.then(data=>{
				const $table=document.createElement("table");
				const rows=data.split("\n");
				rows.forEach(v=>{
					const colVal=v.split(",");
					const $tr=colVal.reduce((init,next)=>{
						const $td=document.createElement("td");
						if(next.lastIndexOf(".")>1){
							const $img=$("<img>").attr({
								"src":"<%=request.getContextPath()%>/resources/images/"+next,
								"width":"100","height":"100"
							});
							$td.appendChild($img[0]);
						}else{
							$td.innerText=next;
						}
						init.appendChild($td);
						return init;
					},document.createElement("tr"));
					$table.appendChild($tr);
					
					$("#member-container").html('');
					$("#member-container").append($table);
				});
			});
		});
	</script>
	
	<h3>xml파일 내용가져오기</h3>
	<button id="xml-btn">xml가져오기</button>
	<div id="xml-result"></div>
	<script>
		$("#xml-btn").click(async e=>{
			const response=await fetch("<%=request.getContextPath()%>/resources/books.xml");
			if(response.ok){
				const data=await response.text();
				/* console.log(data); */
				const xml=new DOMParser().parseFromString(data,"application/xml");
				/* console.log(xml); */
				const root=$(xml).find(":root");
				const books=$(root).find("book");
				books.each((i,book)=>{
					console.log(book);
					$(book).children().each((j,element)=>{
						console.log(element.innerHTML);
					})
				});
			}else{
				alert("요청 실패! 관리자에게 문의하세요! :(");
			}
		})
	</script>

	<h3>json으로 데이터 통신하기</h3>
	<p>
		서버와 클라이언트가 데이터를 주고 받을때 데이터 표현방식<br>
		javascript 객체 표현방식으로 처리<br>
		object : {key:value,key1:value.....}<br>
		array : [value,value1,value....]<br>
		[{},{}] / {key:[]}<br>
	</p>
	<p>
		프론트엔드에서 json을 처리<br>
		new Object() / {}<br>
		js가 json으로 변환해주는 함수를 제공<br>
		JSON.stringify(객체) : js객체를 json방식의 문자열로 변환<br>
		JSON.parse(문자열) : 문자열을 js객체로 변환 * json표현식 준수!<br>
	</p>
	<p>
		백엔드(서버)에서 json을 처리<br>
		라이브러리를 이용함<br>
		1. gson라이브러리 : google에서 만든것, Gson클래스를 이용<br>
		   toJson() : 자바객체를 json표현식으로 만들어주는 메소드 -> 필드명(key) : 필드에 저장된 값(value)<br>
		   fromJson() : json표현식의 문자열을 지정한 자바객체로 만들어주는 메소드 * key와 필드명이 동일해야함<br>
		2. jackson라이브러리 : ObjectMapper클래스를 이용 * spring에서 기본 파서로 이용<br>
		   writeValueAsString() : 자바객체를 json표현식으로 만들어주는 메소드 <br>
		   readValue() : json표현식의 문자열을 지정한 자바객체로 만들어주는 메소드<br>
	</p>
	
	<h2>gson이용해서 객체 주고받기</h2>
	<button onclick="searchNotice();">공지사항조회</button>
	<div id="notice-container"></div>
	<script>
		const searchNotice=async ()=>{
			const response=await fetch("<%=request.getContextPath()%>/ajax/searchnotice.do");
			if(response.ok){
				/* const data=await response.text(); */
				const data=await response.json();
				console.log(data);
				
				
				/* const objData=JSON.parse(data);
				console.log(objData); */
				
			}else{
				alert("요청실패!");
			}
		}
	</script>
	<h3>게시글 조회하기</h3>
	<button id="board-btn">게시글조회</button>
	<div id="board-container"></div>	
	<script>
		document.getElementById("board-btn").addEventListener("click",
				async e=>{
			const response=await fetch("<%=request.getContextPath()%>/ajax/boardlist.do")
			if(response.ok){
				const data=await response.json();
				console.log(data);
				/* const header=Object.keys(data[0]); */
				const header=["번호","제목","작성자","내용","작성일","조회수","댓글"];
				console.log(header);
				const $table=document.createElement("table");
				const $headerTr=makeTr(header,"th");
				$table.appendChild($headerTr);
				data.forEach(e=>{
					const $bodyTr=makeTr(Object.values(e));
					$table.appendChild($bodyTr);
				});
				document.getElementById("board-container").innerHTML="";
				document.getElementById("board-container").appendChild($table);
				
			}else{
				alert("요청실패!");
			}
		});
		function makeTr(dataArr=[],tagType="td"){
			return dataArr.reduce((init,next)=>{
				const $th=document.createElement(tagType);
				$th.innerText=next;
				init.appendChild($th);
				return init;
			},document.createElement("tr"));
		}
	</script>
	
	<h3>ajax로 저장하기</h3>
	<div id="input-container">
		<input type="text" id="userName"><br>
		<input type="text" id="phone"><br>
		<input type="text" id="profile"><br>
		<input type="number" id="age"><br>
		<button	onclick="saveActor()">저장</button>
	</div>
	<script>
		const saveActor=()=>{
			const inputData={};
			$("#input-container>input").each((i,e)=>{
				inputData[e.id]=e.value;
			});
			console.log(inputData);
			
			fetch("<%=request.getContextPath()%>/ajax/saveActor.do",{
				method:"post",
				header:{
					"Content-type":"application/json;charset=utf-8",
				},
				body:JSON.stringify(inputData)
			})
			.then(response=>{
				if(!response.ok){
					throw new Error("요청실패!");
				}
				return response.text();
			}).then(data=>{
				console.log(data);
			});
		}
	</script>
	
	<h3>ajax로 파일업로드 처리하기</h3>
	<input type="file" id="upfile" name="upfile" 
	accept="image/*" style="display:none" multiple>
	<div id="preview">
		클릭하세요
	</div>	
	<button onclick="saveImageFile()">프로필저장</button>
	<script>
		const saveImageFile=()=>{
			//formData객체를 이용해서 처리
			const formData=new FormData();
			const files=$("#upfile")[0].files;
			for(let i=0;i<files.length;i++){
				//formData.append("upfile",$("#upfile")[0].files[0]);
				formData.append("upfile"+i,files[i]);
			}
			formData.append("lunch","명수패거리");
			$.ajax({
				url:"<%=request.getContextPath()%>/fileupload",
				type:"post",
				processData:false,
				contentType:false,
				data:formData,
				success:data=>{
					console.log(data);
				},
				error:response=>{
					console.log(response);
				}
			});
		}
		$("#preview").click(e=>{
			$("#upfile").click();
		});
		$("#upfile").change(e=>{
			$("#preview").html("");
			$.each(e.target.files,(i,file)=>{
				const fileReader=new FileReader();
				/* fileReader.readAsDataURL(e.target.files[0]); */
				fileReader.readAsDataURL(file);
				fileReader.onload=e=>{
					const path=e.target.result;
					const $img=$("<img>").attr({
						"src":path,"width":"200","height":"200"
					});
					$("#preview").append($img);
				}
			})
		});
	</script>



</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>









