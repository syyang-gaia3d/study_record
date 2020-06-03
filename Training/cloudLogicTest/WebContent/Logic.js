/**
 * 위성사진 자료를 16*16으로 쪼개기
 */

// 상수선언
const DENO = 16;

//wkt에서 좌표값 배열 추출
function splitWkt(wkt) {
	let locatStr = wkt.replace(/[A-Z()]/gi,""); //문자 및 괄호 제거
	
	//앞의 공백 제거
	if(locatStr.indexOf(' ') === 0) {
		locatStr = locatStr.replace(/\s+/,''); 
	}
	
	const points = []; //배열선언
	
	//좌표 개수가 1개(point)인지, 여러개(line, polygon)인지 체크
	let comma = /\,/gi;
	
	if(comma.test(locatStr)) {		
		const locatArray = locatStr.split(', ');
		
		//polygon의 경우, 중복좌표 제거
		if(locatArray.length > 4) {
			if(locatArray[0] === locatArray[4]) {
				locatArray.splice(4, 1);				
			}
		}
		
		for(i = 0; i < locatArray.length; i++) {
			
			var pointObj = {}; //객체선언
			
            const locats = locatArray[i].split(' ');
            pointObj.lng = Number(locats[0]);
            pointObj.lat = Number(locats[1]);
            
            points.push(pointObj);
		}
	} else {
        
        const locats = locatStr.split(' ');
        pointObj.lng = Number(locats[0]);
        pointObj.lat = Number(locats[1]);
        
        points.push(pointObj);
	}
	
	return points;
}

// 두 좌표 사이를 16등분한 17개의 좌표 중 index 값에 따른 특정 좌표를 리턴
function equals({lng : x1, lat : y1}, {lng : x2, lat : y2}, index) {

	var point1 = {lng : x1, lat : y1};
	var point2 = {lng : x2, lat : y2};
	
	var result = {}; //객체를 담을 변수 선언
	
	var lng = point1.lng + ((point2.lng - point1.lng)/DENO * index);
	var lat = point1.lat + ((point2.lat - point1.lat)/DENO * index);

	result.lng = lng;
	result.lat = lat;
	
	return result;
}

// 가로 세로 16등분 라인 생성(임시)
function makeLines(points) {
	let top, bottom, left, right;
    
    let lines = [];
    
    for(var i = 0; i < DENO; i++) {
    	
    	top = equals(points[0], points[3], i + 1);
    	bottom = equals(points[1], points[2], i + 1);
    	left = equals(points[0], points[1], i + 1);
    	right = equals(points[3], points[2], i + 1);
    	
        let verti = 'LINESTRING (' + top.lng + ' ' + top.lat + ', ' + bottom.lng + ' ' + bottom.lat + ')';
        
        lines.push(verti);
        
        let hori = 'LINESTRING (' + left.lng  + ' ' + left.lat + ', ' + right.lng + ' ' + right.lat + ')';
        
        lines.push(hori);
    }
    
    return lines;
}