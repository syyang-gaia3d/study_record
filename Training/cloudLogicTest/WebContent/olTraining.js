

//16*16좌표로 polygon 생성(다른 스타일 주기)
function addPolygon(/*ol.source.Vector*/ src, /*폴리곤 객체*/ geom) {
	var feature = new ol.Feature({
		geometry: geom
	});
	
	var style = new ol.style.Style({
		stroke: new ol.style.Stroke({
			color: 'yellow',
			width: 3
		}),
		fill: new ol.sytle.Fill({
			color: 'rgba(0,0,255,0.6)'
		})
	});
	
	feature.setStyle(style);
	feature.set('name', '일반 polygon');
	
	src.addFeature(feature);
}

//위와 같은 polygon을 multi-polygon으로 

//폴리곤을 16 * 16으로 쪼갠 폴리곤 좌표를 가진 geometry * 16값을 return
function makePoly(points) {//points : {lng : a, lat : b}를 가진 배열
	// 어떻게 하면 16개로 쪼갠 polygon의 각 모서리 좌표값을 정형화할 수 있을까?
}