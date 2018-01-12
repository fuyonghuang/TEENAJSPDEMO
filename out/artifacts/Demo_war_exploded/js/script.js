// JavaScript Document

window.onload=function(){
	classify();
	plusses();
	bann();
}


















//商品分类相关
function classify(){
	var titles=$('side-tits').getElementsByTagName('li'),
	    ads=$('classifyad').getElementsByTagName('li'),
	    divs=$('side-con').getElementsByTagName('div');
		//alert(titles.length);
		if(titles.length!=divs.length)
		return;
		for(var i=0;i<titles.length;i++){
			titles[i].id=i;
			ads[i].id=i;
			titles[i].onmouseover=function(){
				for(var j=0;j<titles.length;j++){
					titles[j].className='';
					divs[j].style.display='none';
					ads[j].style.display='none';
					}
				this.className='select';
				divs[this.id].style.display='block';
				ads[this.id].style.display='block';
			}
		}
}
//轮播图相关
//服饰商圈中的进货批发优势说明相关
function plusses(){
	var tits=$('tit2').getElementsByTagName('li'),
	    plusscon=$('plusses-con').getElementsByTagName('div');
		//alert(tits.length);
		if(tits.length!=plusscon.length)
		return;
		for(var i=0;i<tits.length;i++){
			tits[i].id=i;
			tits[i].onmouseover=function(){
				for(var j=0;j<tits.length;j++){
					tits[j].className='';
					plusscon[j].style.display='none';
					}
				this.className='active1';
				plusscon[this.id].style.display='block';
			}
		}
}