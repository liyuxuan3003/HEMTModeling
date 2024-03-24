#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter02A_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


xLaTeX=(MaTeX[
	#1,Magnification->#2,
	"Preamble"->{"\\usepackage{xcolor}","\\usepackage{siunitx}","\\usepackage{physics}","\\usepackage{upgreek}"}])&;
xLabelFont={FontColor->Black,FontFamily->"Latin Modern",FontSize->5};


xFigConfig={
	Frame->True,GridLines->Automatic,ImageSize->Automatic->300,
	FrameStyle->BlackFrame,PlotStyle->ColorData[10],BaseStyle->xLabelFont};
xFigLabel=(FrameLabel->{xLaTeX[#1,0.8],xLaTeX[#2,0.8]})&;


xFig3DConfig={
	ViewPoint->{-100,-80,65},PlotPoints -> 50,MaxRecursion -> 5,
	ExclusionsStyle->{None,{Black,Thin}},ColorFunction->ColorData["DarkRainbow"],
	BaseStyle->xLabelFont};
xFig3DLabel=(AxesLabel->{xLaTeX[#1,0.8],xLaTeX[#2,0.8],xLaTeX[#3,0.8]})&;


xTicks=(Table[{x,xLaTeX[ToString[PaddedForm[x,{#2[[1]],#2[[2]]}]],0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksProp=(Table[{x #3,xLaTeX[ToString[PaddedForm[x,{#2[[1]],#2[[2]]}]],0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog=(Table[{10^x,xLaTeX["10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog1=(Table[{10^x,xLaTeX["1\\times 10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog2=(Table[{2 10^x,xLaTeX["2\\times 10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog5=(Table[{5 10^x,xLaTeX["5\\times 10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;


xGrids=(Table[x,{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xGridsLog=(Flatten[Table[Table[{If[#2[[1]]<=(n 10^x)<=#2[[2]],(n 10^x),{}]},{n,1,9,1}],{x,#1[[1]],#1[[2]],#1[[3]]}]])&;


xText=Style[#1,FontSize->#2,FontFamily->"Noto Serif CJK SC"]&;
xTextConsolas=Style[#1,FontSize->#2,FontFamily->"Consolas"]&;


f=10^(-15);
p=10^(-12);
n=10^(-9);
u=10^(-6);
m=10^(-3);
k=10^(3);
M=10^(6);


xhb=1.054571800 10^-34;
xkB=1.38064852 10^(-23);
xq=1.602176634 10^-19;
xm0=9.109 383 56*10^-31;
xe0=8.854187817 10^-12;
xT=300;


xDOS=3.24 10^17;
xtbar=2.5 10^-8;
xepsi=10.66 10^-11;
xgamma[0]=2.12 10^-12;
xgamma[1]=3.73 10^-12;
xVoff=-2;
xVth=kB T/q;
xCg=epsi/tbar;
xbeta=Cg/(DOS kB T);
xalphan=E/beta;
xalphad=1/beta;
xep=0.3;


rval=
{
	hb->xhb,
	kB->xkB,
	q->xq,
	m0->xm0,
	e0->xe0,
	T->xT,
	DOS->xDOS,
	tbar->xtbar,
	epsi->xepsi,
	gamma->xgamma,
	Voff->xVoff,
	Vth->xVth,
	Cg->xCg,
	beta->xbeta,
	alphan->xalphan,
	alphad->xalphad,
	ep->xep
};


xns=Cg/q (Vgo-Ef);


xVgo=Vg-Voff;
xVgef=Vg-Voff-Ef;
xH=Function[{Vgo},(Vgo+Vth(1-Log[beta Vgon[Vgo]])-(gamma[0]/3)(Cg Vgo/q)^(2/3))/(Vgo(1+Vth/Vgod[Vgo])+(2gamma[0]/3)(Cg Vgo/q)^(2/3))];
xVgon=Function[{Vgo},(Vgo alphan)/Sqrt[Vgo^2+alphan^2]];
xVgod=Function[{Vgo},(Vgo alphad)/Sqrt[Vgo^2+alphad^2]];
xVgoeff=1/2 (Vgo+Sqrt[Vgo^2+4ep^2]);


xEx[0]=gamma[0]ns^(2/3);
xEx[1]=gamma[1]ns^(2/3);


xEf1=Vgo-(2q DOS Vth)/Cg Exp[Vgo/Vth];
xEf2=Vgo((Vth Log[beta Vgo]+gamma[0](Cg Vgo/q)^(2/3))/(Vgo+Vth+(2gamma[0]/3)(Cg Vgo/q)^(2/3)));
xEf3=Vgo((Vth beta Vgo+gamma[0](Cg Vgo/q)^(2/3))/(Vgo(1+beta Vth)+(2gamma[0]/3)(Cg Vgo/q)^(2/3)));
xEfd=Vgo(1-H[Vgo]);
xEf=Vgo-(2Vth Log[1+Exp[Vgo/(2Vth)]])/(1/H[Vgoeff]+(Cg/(q DOS))Exp[-Vgo/(2Vth)]);


xkx=(gamma[#](Cg/q)^(2/3))&;
xxi=(Exp[(Ef-kx[#]Vgef^(2/3))/Vth])&;
xpx=+(Cg/q)Vgef-Sum[DOS Vth Log[xi[i]+1],{i,{0,1}}];
xqx=-(Cg/q)-Sum[DOS/(1+xi[i]^-1) (1+2/3 kx[i]Vgef^(-1/3)),{i,{0,1}}];
xrx=Sum[1/(1+xi[i]^-1) (2/9 Vgef^(-4/3)DOS kx[i](1+xi[i]^-1)+DOS/Vth (1+2/3 kx[i]Vgef^(-1/3))^2),{i,{0,1}}];


xEfext=Ef-px/qx (1+(px rx)/(2qx^2));


rfunc={Vgo->xVgo,Vgef->xVgef,H->xH,Vgon->xVgon,Vgod->xVgod,Vgoeff->xVgoeff,kx->xkx,xi->xxi,px->xpx,qx->xqx,rx->xrx,ns->xns};


xVgsep=Vg//.FindRoot[(xEf==xEx[0])//.Join[rval,rfunc,{Ef->xEf}],{Vg,-2}][[1]];


fig1=Plot[Evaluate[{xEf}//.Join[rval,rfunc]],{Vg,-3,3},
PlotRange->{-1.1,1.1},PlotStyle->Black,
FrameTicks->{xTicks[{-3,3,1},{2,1}],xTicks[{-1,1,0.5},{2,1}]},
Prolog->
{
	Thickness[0.003],Dashed,Gray,
	Line[{{xVoff,-3},{xVoff,+3}}],
	Line[{{xVgsep,-3},{xVgsep,+3}}]
},
PlotLegends->Placed[LineLegend[{
	xLaTeX["E_f",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMargins->0.3,
	LegendMarkerSize->{22,1}],{Right,Bottom}],
Evaluate@xFigLabel["V_g~(\\si{V})","E_f~(\\si{V})"],
Evaluate@xFigConfig]


fig2=Plot[Evaluate[{xEf,xEx[0],xEx[1]}//.Join[rval,rfunc,{Ef->xEf}]],{Vg,-3,3},
PlotRange->{-1.1,1.1},
PlotStyle->{
	Directive[Thickness[0.005],Black],
	Directive[Thickness[0.005],Blue],
	Directive[Thickness[0.005],Red]
},
Prolog->
{
	Thickness[0.003],Dashed,Gray,
	Line[{{xVoff,-3},{xVoff,+3}}],
	Line[{{xVgsep,-3},{xVgsep,+3}}]
},
PlotLegends->Placed[LineLegend[{
	xLaTeX["E_f",0.7],
	xLaTeX["E_0",0.7],
	xLaTeX["E_1",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMargins->0.3,
	LegendMarkerSize->{22,1}],{Right,Bottom}],
FrameTicks->{xTicks[{-3,3,1},{2,1}],xTicks[{-1,1,0.5},{2,1}]},
Evaluate@xFigLabel["V_g~(\\si{V})","E_f,E_0,E_1~(\\si{V})"],
Evaluate@xFigConfig]


fig3=Plot[Evaluate[{xEf1,xEf2,xEf3}//.Join[rval,rfunc]],{Vg,-3,3},PlotRange->{-1.1,1.1},
PlotPoints->500,
PlotStyle->{
	Directive[Red],
	Directive[Lighter[Lighter[Blue]]],
	Directive[Blue]
},
Prolog->
{
	Thickness[0.003],Dashed,Gray,
	Line[{{xVoff,-3},{xVoff,+3}}],
	Line[{{xVgsep,-3},{xVgsep,+3}}]
},
PlotLegends->Placed[LineLegend[{
	xLaTeX["E_{f,sub}",0.7],
	xLaTeX["E_{f,above1}",0.7],
	xLaTeX["E_{f,above2}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMargins->0.3,
	LegendMarkerSize->{22,1}],{Right,Bottom}],
FrameTicks->{xTicks[{-3,3,1},{2,1}],xTicks[{-1,1,0.5},{2,1}]},
Evaluate@xFigLabel["V_g~(\\si{V})","E_f~(\\si{V})"],
Evaluate@xFigConfig]


fig4=Plot[Evaluate[{xEf1,xEf2,xEf3,xEfd}//.Join[rval,rfunc]],{Vg,-2.2,-1.0},
PlotPoints->500,PlotRange->{-0.24,0.24},
PlotStyle->{
	Directive[Red],
	Directive[Lighter[Lighter[Blue]]],
	Directive[Blue],
	Directive[Black,Dashed,Thickness[0.007]]
},
Prolog->
{
	Thickness[0.003],Dashed,Gray,
	Line[{{xVoff,-3},{xVoff,+3}}],
	Line[{{xVgsep,-3},{xVgsep,+3}}]
},
PlotLegends->Placed[LineLegend[{
	xLaTeX["E_{f,sub}",0.7],
	xLaTeX["E_{f,above1}",0.7],
	xLaTeX["E_{f,above2}",0.7],
	xLaTeX["E_{f,above}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMargins->0.3,
	LegendMarkerSize->{22,1}],{Right,Bottom}],
FrameTicks->{xTicks[{-2.2,-1,0.2},{2,1}],xTicks[{-0.2,0.2,0.1},{3,2}]},
Evaluate@xFigLabel["V_g~(\\si{V})","E_f~(\\si{V})"],
Evaluate@xFigConfig]


fig5=Plot[Evaluate[{xEf1,xEf2,xEf3,xEf}//.Join[rval,rfunc]],{Vg,-2.2,-1.0},
PlotPoints->500,PlotRange->{-0.24,0.24},
PlotStyle->{
	Directive[Red],
	Directive[Lighter[Lighter[Blue]]],
	Directive[Blue],
	Directive[Black,Dashed,Thickness[0.007]]
},
Prolog->
{
	Thickness[0.003],Dashed,Gray,
	Line[{{xVoff,-3},{xVoff,+3}}],
	Line[{{xVgsep,-3},{xVgsep,+3}}]
},
PlotLegends->Placed[LineLegend[{
	xLaTeX["E_{f,sub}",0.7],
	xLaTeX["E_{f,above1}",0.7],
	xLaTeX["E_{f,above2}",0.7],
	xLaTeX["E_{f,unified}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMargins->0.3,
	LegendMarkerSize->{22,1}],{Right,Bottom}],
FrameTicks->{xTicks[{-2.2,-1,0.2},{2,1}],xTicks[{-0.2,0.2,0.1},{3,2}]},
Evaluate@xFigLabel["V_g~(\\si{V})","E_f~(\\si{V})"],
Evaluate@xFigConfig]


fig6=LogPlot[Evaluate[{xns}//.Join[rval,rfunc,{Ef->xEf}]],{Vg,-3,3},
PlotStyle->Black,PlotRange->{0.5 10^13,2 10^17},
FrameTicks->{xTicks[{-3,3,1},{2,1}],xTicksLog[{13,17,1}]},
GridLines->{Automatic,xGridsLog[{13,17,1},{10^13,10^17}]},
Prolog->
{
	Thickness[0.003],Dashed,Gray,
	Line[{{xVoff,Log[10^12]},{xVoff,Log[10^18]}}],
	Line[{{xVgsep,Log[10^12]},{xVgsep,Log[10^18]}}]
},
PlotLegends->Placed[LineLegend[{
	xLaTeX["n_s",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMargins->0.3,
	LegendMarkerSize->{22,1}],{Right,Bottom}],
Evaluate@xFigLabel["V_g~(\\si{V})","n_s~(\\si{m^{-2}})"],
Evaluate@xFigConfig]


fig7=Plot[xVgoeff//.Join[{ep->xep}],{Vgo,0,2},
PlotLegends->Placed[LineLegend[{
	xLaTeX["V_{go,eff}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMargins->0.3,
	LegendMarkerSize->{22,1}],{Right,Bottom}],
PlotStyle->Black,PlotRange->{-0.2,2.2},
FrameTicks->{xTicks[{0,2,0.5},{2,1}],xTicks[{0,2,0.5},{2,1}]},
Evaluate@xFigLabel["V_{go}~(\\si{V})","V_{go,eff}~(\\si{V})"],
Evaluate@xFigConfig]


fig8=Plot[Evaluate[{xVgon[Vgo],xVgod[Vgo]}//.Join[rval]],{Vgo,0,2},
PlotLegends->Placed[LineLegend[{
	xLaTeX["V_{gon}",0.7],
	xLaTeX["V_{god}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMargins->0.3,
	LegendMarkerSize->{22,1}],{Right,Bottom}],
PlotStyle->{Black,Gray},PlotRange->{-0.05,1.05},
FrameTicks->{xTicks[{0,2,0.5},{2,1}],xTicks[{0,1,0.2},{2,1}]},
Evaluate@xFigLabel["V_{go}~(\\si{V})","V_{gon},V_{god}~(\\si{V})"],
Evaluate@xFigConfig]


fig={fig1,fig2,fig3,fig4,fig5,fig6,fig7,fig8}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]



