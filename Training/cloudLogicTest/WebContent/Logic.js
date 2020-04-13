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
	
	const points = [[],[]]; //배열선언
	
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
            
            const locats = locatArray[i].split(' ');
            points[0].push(Number(locats[0]));
            points[1].push(Number(locats[1]));
		}
	} else {
        
        const locats = locatStr.split(' ');
        points[0].push(Number(locats[0]));
        points[1].push(Number(locats[1]));
	}
	
	return points;
}

// 두 좌표 사이를 16등분한 17개의 좌표 중 index 값에 따른 특정 좌표를 리턴
function equals(lng1, lat1, lng2, lat2, index) {
    const points = [[], []]; //[0][] = 경도(lng), [1][] = 위도(lat)
	
	//간격
	let lng_equals = (lng2 - lng1)/DENO;
	let lat_equals = (lat2 - lat1)/DENO;

	points[0][0] = lng1;
	points[1][0] = lat1;
	
	for (i = 0; i < DENO; i++) { 
		points[0][i+1] = points[0][i] + lng_equals;
		points[1][i+1] = points[1][i] + lat_equals;
		
	}
	
	const point = String(points[0][index] + ', ' + points[1][index]);
	
	return point;
}

// 한 선분을 16등분하는 점중에 원하는 좌표로 WKT 출력
function makePoint(lng1, lat1, lng2, lat2, index) {
	let point = equals(lng1, lat1, lng2, lat2, index);
	
	let lng = point.split(', ')[0];
	let lat = point.split(', ')[1];
	
	let pointWkt = 'POINT(' + lng + ' ' + lat + ')';
	
	return pointWkt;
}

// 가로 세로 16등분 라인 생성(임시)
function makeLines(points) {
    
    let topLeft = equals(points[0][0], points[1][0], points[0][3], points[1][3], 0);
    let topRight = equals(points[0][0], points[1][0], points[0][3], points[1][3], 16);
    let bottom = equals(points[0][1], points[1][1], points[0][2], points[1][2], 0);
    let left = equals(points[0][0], points[1][0], points[0][1], points[1][1], 0);
    let right = equals(points[0][3], points[1][3], points[0][2], points[1][2], 0);
    
    let lines = [];
    
    for(i = 1; i < DENO; i++) {
        let verti = 'LINESTRING (' + top[0][i] + ' ' + top[1][i] + ', '
                 + bottom[0][i] + ' ' + bottom[1][i] + ')';
        
        lines.push(verti);
        
        let hori = 'LINESTRING (' + left[0][i] + ' ' + left[1][i] + ', '
                  + right[0][i] + ' ' + right[1][i] + ')';
        
        lines.push(hori);
    }
    
    return lines;
}

// 두 라인간 교점 좌표