(function(n){n.fn.autogrow=function(){return this.filter("textarea").each(function(){var t=n(this),u=t.height(),f=t.css("lineHeight"),r=n("<div><\/div>").css({position:"absolute",top:-1e4,left:-1e4,width:n(this).width(),fontSize:t.css("fontSize"),fontFamily:t.css("fontFamily"),lineHeight:t.css("lineHeight"),resize:"none"}).appendTo(document.body),i=function(){var t=this.value.replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/&/g,"&amp;").replace(/\n/g,"<br/>");r.html(t),n(this).css("height",Math.max(r.height()+20,u))};n(this).change(i).keyup(i).keydown(i),i.apply(this)}),this}})(jQuery)