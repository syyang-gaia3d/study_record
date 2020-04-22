//2.12 사용자 정의 필터 셀렉터 만들기

//jQuery.expr[':'] //jQuery 셀렉터 식 확장(Sizzle.selectors.filters의 별칭)
// 각각의 새로운 필터 식은 이 개체의 속성으로써 정의됨

jQuery.expr[':'].newFilter = function(elem, index, match) {
    return true; // filter() 메서드처럼 true/false 반환
}


// 논의
// match -> jQuery 가 셀렉터 문자열을 대상으로 수행하는 정규 표현식 매치로부터 반환되는 배열
// => 파라미터를 수용하는 필터식을 만들 때 매우 유용

// ex : jQuery 가 보유하고 있는 데이터를 질의하는 셀렉터를 만들 경우
jQuery('span').data('something', 123);

//우린 이것이 가능하길 원한다.
jQuery('*:data(something, 123)'); 
// 셀렉터의 목적은 jQuery의 data() 메서드를 통해 추가된 데이터를 가지고있는 모든 요소들을 선택하는 것
// 즉, 데이터 key로 something을 가지며, 그 값이 123인 요소들을 찾는 것

//필터(:data) 만들기
jQuery.expr[':'].data = function(elem, index, m) {
    //매치에서 ":data("와 이어지는 ")"라는 글자를 제거해야 한다. 필요치 않으므로
    m[0] = m[0].replace(/:data\(|\)$/g, '');

    var regex = new RegExp('([\'"]?) ((?:\\\\\\1|.)+?)\\1(,|$)', 'g'),
    // 데이터 키를 가져온다.
    key = regex.exec( m[0] )[2],
    // 데이터 값을 가져온다.
    val = regex.exec( m[0] );
    if(val) {
        val = val[2];
    }

    // 값이 지정되었다면 그를 검사한다. 그렇지 않으면 값이 true인지 검사한다.
    return val ? jQuery(elem).data(key) == val : !!jQuery(elem).data(key);
}

// 복잡한 정규 표현식을 사용한 이유? 가능한 유연하게 만들고자

// 활용1. 위의 예시처럼
jQuery('div:data("something",123)');
// 활용2. 'something'이 '참'값인지 여부 검사
jQuery('div:data(something)');
// 활용3. 따옴표가 있거나 없거나의 경우
jQuery('div:data(something, "something else"');



// 동시에 하나 이상의 새로운 셀렉터를 추가하고자 한다면
jQuery.extend(jQuery.expr[':'], {
    newFilter1 : function(elem, index, match) {
        //return true or false
    },
    newFilter2 : function(elem, index, match) {
        //return true or false
    },
    newFilter3 : function(elem, index, match) {
        //return true or false
    }
});