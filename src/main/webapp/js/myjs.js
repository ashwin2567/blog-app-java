function doLike(pid, uid){
	console.log(pid+","+uid);
	const d = {
		likedBy:uid,
		postId:pid,
		operation:'like'
	
	}
	$.ajax({
		url : "LikeServlet",
		data: d,
		success : function(data, textStatus, jqXHR) {
			console.log(data);
			if(data.trim()=='done')
			{
				let c = $(".like-counter").html();
				c++;
				$(".like-counter").html(c);
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			console.log(data);
		}
	});
}