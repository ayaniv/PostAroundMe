var gapi=window.gapi=window.gapi||{};(function(){var k=void 0,n=!0,r=null,t=!1,aa=encodeURIComponent,v=window,ba=parseInt,w=document,x="push",y="test",z="replace",A="indexOf",B="createElement",C="setAttribute",ca="getElementsByTagName",D="length",da="size",ea="split",E="location",F="call",I="getAttribute",J="href",K="action",L="apply",M="join",N="toLowerCase";var O=v,fa=w,ga=O[E],ha=function(){},ia=/\[native code\]/,P=function(a,b,c){return a[b]=a[b]||c},ja=function(a){for(var b=0;b<this[D];b++)if(this[b]===a)return b;return-1},ka=/&/g,la=/</g,ma=/>/g,na=/"/g,oa=/'/g,pa=function(a){return(""+a)[z](ka,"&amp;")[z](la,"&lt;")[z](ma,"&gt;")[z](na,"&quot;")[z](oa,"&#39;")},Q=function(){var a;if((a=Object.create)&&ia[y](a))a=a(r);else{a={};for(var b in a)a[b]=k}return a},R=function(a,b){return Object.prototype.hasOwnProperty[F](a,b)},S=function(a,b){var a=a||
{},c;for(c in a)R(a,c)&&(b[c]=a[c])},T=P(O,"gapi",{});var qa=function(a,b,c){b=RegExp("([?#].*&|[?#])"+b+"=([^&#]*)","g");if(a=a&&b.exec(a))try{c=decodeURIComponent(a[2])}catch(d){}return c},ra=/^([^?#]*)(\?([^#]*))?(\#(.*))?$/,sa=function(a){var b=[];if(a)for(var c in a)R(a,c)&&a[c]!=r&&b[x](aa(c)+"="+aa(a[c]));return b},ta=function(a,b,c){var a=a.match(ra),d=Q();d.n=a[1];d.d=a[3]?[a[3]]:[];d.c=a[5]?[a[5]]:[];d.d[x][L](d.d,sa(b));d.c[x][L](d.c,sa(c));return d.n+(0<d.d[D]?"?"+d.d[M]("&"):"")+(0<d.c[D]?"#"+d.c[M]("&"):"")};var ua=function(a,b,c){if(O[b+"EventListener"])O[b+"EventListener"]("message",a,t);else if(O[c+"tachEvent"])O[c+"tachEvent"]("onmessage",a)};var U;U=P(O,"___jsl",Q());P(U,"I",0);var va=function(a){return qa(a,"jsh",U.h)},wa=function(a){return P(P(U,"H",Q()),a,Q())};var xa=Q(),V=[],W;W={a:"callback",l:"sync",k:"config",b:"_c",g:"h",e:"platform",i:"ds",j:"jsl"};V[x]([W.j,function(a){for(var b in a)if(R(a,b)){var c=a[b];"object"==typeof c?U[b]=P(U,b,[]).concat(c):P(U,b,c)}if(a=a.u)b=P(U,"us",[]),b[x](a),(c=/^https:(.*)$/.exec(a))&&b[x]("http:"+c[1]),P(U,"u",a)}]);xa.m=function(a){var b=U.ms||"https://apis.google.com",a=a[0];if(!a||0<=a[A](".."))throw"Bad hint";return b+"/"+a[z](/^\//,"")};
var ya=function(a){return a[M](",")[z](/\./g,"_")[z](/-/g,"_")},za=function(a,b){for(var c=[],d=0;d<a[D];++d){var e=a[d];e&&0>ja[F](b,e)&&c[x](e)}return c},Aa=function(a){var b=fa[B]("script");b[C]("src",a);b.async="true";a=fa[ca]("script")[0];a.parentNode.insertBefore(b,a)},Ba=function(a,b){var c=b||{};"function"==typeof b&&(c={},c[W.a]=b);var d=c,e=d&&d[W.b];if(e)for(var f=0;f<V[D];f++){var l=V[f][0],i=V[f][1];i&&R(e,l)&&i(e[l],a,d)}if(!(d=c[W.g]))if(d=va(ga[J]),!d)throw"Bad hint";var m=d,p=c[W.a],
g=c[W.k],d=P(wa(m),"r",[]).sort(),h=P(wa(m),"L",[]).sort(),j=function(a){h[x][L](h,u);var b=((T||{}).config||{}).update;b?b(g):g&&P(U,"cu",[])[x](g);if(a){b=m===va(ga[J])?P(T,"_",Q()):Q();b=P(wa(m),"_",b);a(b)}p&&p();return 1};if(a){e=a[ea](":").sort();f=[];l=k;for(i=0;i<e[D];i++){var o=e[i];o!=l&&f[x](o);l=o}e=f}else e=[];var u=za(e,h);if(!u[D])return j();var u=za(e,d),s=U.I++,q="loaded_"+s;T[q]=function(a){if(!a)return 0;var b=function(){T[q]=r;return j(a)};if(T["loaded_"+(s-1)])T[q]=b;else for(b();b=
T["loaded_"+ ++s];)if(!b())break};if(!u[D])return T[q](ha);e=m[ea](";");e=(f=xa[e.shift()])&&f(e);if(!e)throw"Bad hint:"+m;e=e[z]("__features__",ya(u))[z](/\/$/,"")+(d[D]?"/ed=1/exm="+ya(d):"")+("/cb=gapi."+q);d[x][L](d,u);c[W.l]||O.___gapisync?(c=e,"loading"!=fa.readyState?Aa(c):fa.write(['<script src="',c,'"><\/script>'][M](""))):Aa(e)};T.load=Ba;var Ca=function(){return v.___jsl=v.___jsl||{}},Da=function(a){var b=Ca();b[a]=b[a]||[];return b[a]},X=function(a){var b=Ca();b.cfg=!a&&b.cfg||{};return b.cfg},Ea=function(a){return"object"===typeof a&&/\[native code\]/[y](a[x])},Y=function(a,b){if(b)for(var c in b)b.hasOwnProperty(c)&&(a[c]&&b[c]&&"object"===typeof a[c]&&"object"===typeof b[c]&&!Ea(a[c])&&!Ea(b[c])?Y(a[c],b[c]):b[c]&&"object"===typeof b[c]?(a[c]=Ea(b[c])?[]:{},Y(a[c],b[c])):a[c]=b[c])},Fa=function(a){if(a){var b="",c=a.nodeType;
if(3==c||4==c)b=a.nodeValue;else if(a.innerText)b=a.innerText;else if(a.innerHTML)b=a.innerHTML;else if(a.firstChild){b=[];for(a=a.firstChild;a;a=a.nextSibling)b[x](Fa(a));b=b[M]("")}return b}},Z=function(a){if(!a)return X();for(var a=a[ea]("/"),b=X(),c=0,d=a[D];b&&"object"===typeof b&&c<d;++c)b=b[a[c]];return c===a[D]&&b!==k?b:k};var $=v,Ga=w;var Ha,Ia=Q(),Ja=P(U,"FW",[]),Ka=function(){},La=function(a,b){for(var c=Q(),d=fa[ca]("*"),e=0;e<d[D];++e){var f=d[e],l=f.nodeName[N](),i=k;if(!f[I]("data-gapiscan")&&(0==l[A]("g:")?i=l.substr(2):(l=""+(f.className||f[I]("class")))&&0==l[A]("g-")&&(i=l.substr(2)),i&&Ia[i]))f[C]("data-gapiscan",n),P(c,i,[])[x](f)}var m=[],d="explicit"==Z("parsetags");if(b)for(var p in c){e=c[p];for(f=0;f<e[D];f++)e[f][C]("data-onload",n)}for(var g in c)Ja[x](g),(T[g]&&T[g].go||d)&&m[x](g);p={};if(0<m[D])var h=a,a=
function(){for(var a=0;a<m[D];a++)T[m[a]].go();h&&h()};p[W.a]=a;g=Ja[M](":");Ba(g,p);Ka(g,c,Ha)};
V[x]([W.e,function(a,b,c){Ha=c;b&&Ja[x](b);for(b=0;b<a[D];b++)Ia[a[b]]=1;if(c)for(var b=P(c[W.b],W.i,[]),d=0;d<a[D];d++)b[x](["gapi",a[d],"go"][M](".")),b[x](["gapi",a[d],"render"][M]("."));if(a=v.__GOOGLEAPIS)P(U,"ci",[])[x](a),v.__GOOGLEAPIS=k;X(n);b=v.___gcfg;a=Da("cu");b&&b!==v.___gu&&(d={},Y(d,b),a[x](d),v.___gu=b);var b=Da("cu"),e=w.scripts||w[ca]("script")||[],d=[],f=[],l=Ca().u;l&&f[x](l);Ca().us&&f[x][L](f,Ca().us);for(l=0;l<e[D];++l)for(var i=e[l],m=0;m<f[D];++m)i.src&&0==i.src[A](f[m])&&
d[x](i);0==d[D]&&e[e[D]-1].src&&d[x](e[e[D]-1]);for(e=0;e<d[D];++e)if(!d[e][I]("gapi_processed")){d[e][C]("gapi_processed",n);if(f=Fa(d[e])){for(;0==f.charCodeAt(f[D]-1);)f=f.substring(0,f[D]-1);l=k;try{l=(new Function("return ("+f+"\n)"))()}catch(p){}if("object"===typeof l)f=l;else{try{l=(new Function("return ({"+f+"\n})"))()}catch(g){}f="object"===typeof l?l:{}}}else f=k;f&&b[x](f)}e=Da("cd");b=0;for(d=e[D];b<d;++b)Y(X(),e[b]);e=Da("ci");b=0;for(d=e[D];b<d;++b)Y(X(),e[b]);b=0;for(d=a[D];b<d;++b)Y(X(),
a[b]);if("explicit"!=Z("parsetags")){var h;if(c){var j=c[W.a];j&&(h=function(){O.setTimeout(j,0)},c[W.a]=k)}var o=function(){La(h,n)};if("complete"===Ga.readyState)o();else{var u=t,s=function(){if(!u){u=n;return o[L](this,arguments)}};$.addEventListener?($.addEventListener("load",s,t),$.addEventListener("DOMContentLoaded",s,t)):$.attachEvent&&($.attachEvent("onreadystatechange",function(){Ga.readyState==="complete"&&s[L](this,arguments)}),$.attachEvent("onload",s))}La(k,n)}}]);P(T,W.e,{}).go=function(a){La(a,t)};var Ma=/^\{h\:'/,Na=/^!_/,Oa=function(a,b){a=""+a;if(Ma[y](a))return n;a=a[z](Na,"");if(!/^\{/[y](a))return t;try{var c=v.JSON.parse(a)}catch(d){return t}if(!c)return t;var e=c.f;return c.s&&e&&-1!=ja[F](b,e)?n:t};var Pa=["left","right"],Qa="inline bubble none only pp vertical-bubble".split(" "),Ra=function(a){var b=w[B]("div"),c=w[B]("a");c.href=a;b.appendChild(c);b.innerHTML=b.innerHTML;return b.firstChild[J]},Sa=function(){return v[E].origin||v[E].protocol+"//"+v[E].host},Ta=function(a,b,c,d){if(a)a=Ra(a);else a:{a=d||"canonical";b=w[ca]("link");c=0;for(d=b[D];c<d;c++){var e=b[c],f=e[I]("rel");if(f&&f[N]()==a&&(e=e[I]("href")))if(e=Ra(e)){a=e;break a}}a=v[E][J]}return a},Wa=function(a,b){if("string"==typeof a){var c;
for(c=0;c<b[D];c++)if(b[c]==a[N]())return a[N]()}},Xa=function(a){return Wa(a,Pa)},Ya=function(a){return Wa(a,Qa)},Za={tall:{"true":{width:50,height:60},"false":{width:50,height:24}},small:{"false":{width:24,height:15},"true":{width:70,height:15}},medium:{"false":{width:32,height:20},"true":{width:90,height:20}},standard:{"false":{width:38,height:24},"true":{width:106,height:24}}},$a=function(a){return"string"==typeof a?""!=a&&"0"!=a&&"false"!=a[N]():!!a},ab=function(a){var b=ba(a,10);if(b==a)return""+
b},bb=function(a){if($a(a))return"true"},cb=function(a){return"string"==typeof a&&Za[a[N]()]?a[N]():"standard"},db={href:[Ta,"url"],width:[ab],size:[cb],resize:[bb],autosize:[bb],count:[function(a,b){return"tall"==cb(b[da])?"true":b.count==r||$a(b.count)?"true":"false"}],db:[function(a,b,c){a==r&&c&&(a=c.db,a==r&&(a=c.gwidget&&c.gwidget.db));return $a(a)?1:k}],ecp:[function(a,b,c){a==r&&c&&(a=c.ecp,a==r&&(a=c.gwidget&&c.gwidget.ecp));if($a(a))return"true"}],textcolor:[function(a){if("string"==typeof a&&
a.match(/^[0-9A-F]{6}$/i))return a}],drm:[bb],recommendations:[],ad:[bb],cr:[ab],ag:[ab],"fr-ai":[],"fr-sigh":[]};var eb={badge:{width:300,height:131},smallbadge:{width:300,height:69}},fb=function(a){return"string"==typeof a&&eb[a[N]()]?a[N]():"badge"};var gb={allowtransparency:"true",frameborder:"0",hspace:"0",marginheight:"0",marginwidth:"0",scrolling:"no",style:"",tabindex:"0",vspace:"0",width:"100%"},hb=0;var ib=/:([a-zA-Z_]+):/g,jb=["onPlusOne","_ready","_close,_open","_resizeMe","_renderstart"],kb={},lb=r,mb=P(U,"WI",Q()),nb=function(){var a=Z("googleapis.config/sessionIndex");a==r&&(a=v.__X_GOOG_AUTHUSER);if(a==r){var b=v.google;b&&(a=b.authuser)}a==r&&(a=k,a==r&&(a=v[E][J]),a=a?qa(a,"authuser"):r);return a==r?r:""+a},ob=function(a,b){if(!lb){var c=Z("iframes/:socialhost:"),d=nb()||"0",e=nb();lb={socialhost:c,session_index:d,session_prefix:e!==k&&e!==r&&""!==e?"u/"+e+"/":""}}return lb[b]||""},pb=
function(a,b){var c={};S(b,c);var d;d=Ta(c[J],0,0,b[K]?r:"publisher");c.url=d;delete c[J];c.hl=Z("lang")||"en-US";c.size=fb(b[da]);d=b.width;c.width=!d?b[K]?k:eb[fb(b[da])].width:ba(d);d=b.height;c.height=!d?b[K]?k:eb[fb(b[da])].height:ba(d);c.origin=Sa();return c},qb=["style","data-gapiscan"],rb=function(a){var b=k;"number"===typeof a?b=a:"string"===typeof a&&(b=ba(a,10));return b};kb.plusone=[function(a,b){var c={};S(db,c);c.source=[r,"source"];c.expandTo=[r,"expandTo"];c.align=[Xa];c.annotation=[Ya];c.origin=[Sa];var d={},e=Z(),f;for(f in c)c.hasOwnProperty(f)&&(d[c[f][1]||f]=(c[f]&&c[f][0]||function(a){return a})(b[f[N]()],b,e));return d}];Ka=function(a,b,c){for(var d=[W.b,W.j,W.g],e=0;e<d[D]&&c;e++)c=c[d[e]];if(c&&!(0==c[A]("n;")&&c!=va(ga[J]))){var f=[],l;for(l in b){c=b[l];d=0;for(e=c[D];d<e;d++){var i;var m=l;i=c[d];var p=e;if(i.parentNode){var g;g=i;for(var h=Q(),j=0!=g.nodeName[N]()[A]("g:"),o=0,u=g.attributes[D];o<u;o++){var s=g.attributes[o],q=s.name,s=s.value;0<=ja[F](qb,q)||(j&&0!=q[A]("data-")||"null"===s)||(j&&(q=q.substr(5)),h[q[N]()]=s)}j=h;g=g.style;(o=rb(g&&g.height))&&(j.height=""+o);(g=rb(g&&g.width))&&(j.width=""+
g);g=h;h=m;j=k;j=h;"plus"==h&&g[K]&&(j=h+"_"+g[K]);(j=Z("iframes/"+j+"/url"))||(j=":socialhost:/_/widget/render/"+h);h=j[z](ib,ob);j=((kb[m]||[])[0]||pb)(m,g);j.hl=Z("lang")||"en-US";U.ILI&&(j.iloader=1);delete j["data-onload"];o=Z("inline/css");"undefined"!==typeof o&&o>=p&&(j.ic=1);j=p=j;o=/^#|^fr-/;u={};q=k;for(q in j)R(j,q)&&o[y](q)&&(u[q[z](o,"")]=j[q],delete j[q]);var o=j=u,u=m,q=g,s=p,G=[].concat(jb),H=Z("iframes/"+u+"/methods");"object"===typeof H&&ia[y](H[x])&&(G=G.concat(H));H=k;for(H in q)if(R(q,
H)&&/^on/[y](H)&&("plus"!=u||"onconnect"!=H))G[x](H),delete s[H];o._methods=G[M](",");h=ta(h,p,j);p=m;m=w[B]("div");i[C]("data-gapistub",n);j=m;P(mb,p,0);p="___"+p+"_"+mb[p]++;j.id=p;m.style.cssText="position:absolute;width:100px;left:-10000px;";m[C]("data-gwattr",sa(g)[M](":"));i.parentNode.insertBefore(m,i);p=h;i=m;h={};g=m=i.ownerDocument;j=h;o=k;u=0;do o=j.id||["I",hb++,"_",(new Date).getTime()][M]("");while(g.getElementById(o)&&5>++u);if(!(5>u))throw Error("Error creating iframe id");g=o;o=m;
u=g;j=h;s=o[E][J];q=Q();(G=qa(s,"_bsh",U.bsh))&&(q._bsh=G);(s=va(s))&&(q.jsh=s);s=k;G=Q();G.id=u;G.parent=o[E].protocol+"//"+o[E].host;o=G;j.hintInFragment?S(q,o):s=q;p=ta(p,s,o);j=h;h=Q();S(gb,h);h.name=h.id=g;S(j.attributes,h);h.src=p;g=k;try{g=m[B]('<iframe frameborder="'+pa(h.frameborder)+'" scrolling="'+pa(h.scrolling)+'" name="'+pa(h.name)+'"/>')}catch(sb){g=m[B]("iframe")}m=k;for(m in h)p=h[m],"style"==m&&"object"===typeof p?S(p,g.style):g[C](m,h[m]);i.innerHTML="";i.appendChild(g);h.allowtransparency&&
(g.allowTransparency=n);i=g[I]("id")}else i=r;i&&f[x](i)}}var Va=function(){ua(Ua,"remove","de")},Ua=function(b){var c=b.data,d=b.origin;Oa(c,f)&&Ba(a,function(){Va();for(var a=P(U,"RPMQ",[]),b=0;b<a[D];b++)a[b]({data:c,origin:d})})};0===f[D]||(!v.JSON||!v.JSON.parse)||(ua(Ua,"add","at"),Ba(a,Va))}};V[x]([W.i,function(a,b,c){for(var d=[].slice,b=0,e;e=a[b];++b){for(var f=O,l=e[ea]("."),i=0;i<l[D]-1;++i)f=P(f,l[i],{});i=l[i];f[i]||(f[i]=function(){var a=3==l[D]?l[l[D]-2]:"",b=c[W.b][W.e],f="gapi"==l[0]&&b&&0<=ja[F](b,a),h=[],b=e;P(U,"df",Q())[b]=function(a){for(var b=0;h[b];++b)a[L](O,h[b])};return function(){h[x](d[F](arguments,0));f&&Ba(a)}}())}}]);})();
gapi.load("plusone",{callback:window["gapi_onload"],_c:{"platform":["plusone","plus","additnow","card","localreview"],"jsl":{"u":"https://apis.google.com/js/plusone.js","ci":{"inline":{"css":0},"lexps":[34,70,38,65,36,40,44,15,45,51,17,48,61,60,30],"oauth-flow":{},"report":{},"iframes":{"additnow":{"url":"https://apis.google.com/additnow/additnow.html?bsv=pr"},"plus":{"methods":["onauth"],"url":":socialhost:/u/:session_index:/_/pages/badge?bsv=pr"},":socialhost:":"https://plusone.google.com","configurator":{"url":":socialhost:/:session_prefix:_/plusbuttonconfigurator"},"localreview":{"params":{"url":""},"url":":socialhost:/:session_prefix:_/local/review?bsv=pr"},"plus_circle":{"params":{"url":""},"url":":socialhost:/:session_prefix:_/widget/plus/circle?bsv=pr"},"evwidget":{"params":{"url":""},"url":":socialhost:/:session_prefix:_/events/widget?bsv=pr"},":signuphost:":"https://plus.google.com","plusone":{"preloadUrl":["https://ssl.gstatic.com/s2/oz/images/stars/po/Publisher/sprite4-a67f741843ffc4220554c34bd01bb0bb.png"],"params":{"count":"","url":"","size":""},"url":":socialhost:/:session_prefix:_/+1/fastbutton?bsv=pr"},"plus_share":{"params":{"url":""},"url":":socialhost:/:session_prefix:_/+1/sharebutton?plusShare=true&bsv=pr"}},"isPlusUser":true,"debug":{"host":"https://plusone.google.com","reportExceptionRate":0,"rethrowException":false},"googleapis.config":{"mobilesignupurl":"https://m.google.com/app/plus/oob?"}},"h":"m;/_/apps-static/_/js/gapi/__features__/rt=j/ver=xxU9vIxbk08.en./sv=1/am=!qLLHE7Oi5aqouyVLxg/d=1/rs=AItRSTMk3U2gTkZWlSjVH6xXYMUOH4i6WQ","fp":"e05d8c9b537030c7a97f984a8ffaef433212699d"},"ds":["gapi.plusone.go","gapi.plusone.render","gapi.plus.go","gapi.plus.render"],"fp":"e05d8c9b537030c7a97f984a8ffaef433212699d"}});