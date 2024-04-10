#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter02D_01.fig.wls";
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
xmu0=170 10^-3;
xmua=10^-9;
xmub=10^-18;
xvsat=1.9 10^5;
xtsat=1;
xdelta=2;
xlambda=0.1;
xeta0=10^-3;
xVDSCALE=5;
xNF=1;
xLSG=1u;
xns0accs=1 10^17; (*\:539f\:65875e17\:592a\:9ad8*)
xmu0accs=155 10^-3;
xvsataccs=2 10^5; (*\:4fee\:6539\:4e86\:ff0c\:539f\:6587\:592a\:4f4e*)
xmaccs=2;
xRSC=10^-4;


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
	ep->xep,
	mu0->xmu0,
	mua->xmua,
	mub->xmub,
	vsat->xvsat,
	tsat->xtsat,
	delta->xdelta,
	lambda->xlambda,
	eta0->xeta0,
	VDSCALE->xVDSCALE,
	NF->xNF,
	LSG->xLSG,
	ns0accs->xns0accs,
	mu0accs->xmu0accs,
	vsataccs->xvsataccs,
	maccs->xmaccs,
	RSC->xRSC
};


xRsacc=LSG/(W NF q ns0accs mu0accs) (1-(Id/Isats)^maccs)^(-1/maccs);
xRsc=RSC/(W NF);
xIsats=W NF q ns0accs vsataccs;


rfunc={Rsacc->xRsacc,Rsc->xRsc,Isats->xIsats};


(xIsats//.Join[rval,rfunc,{W->1u}])/m


xRsc//.Join[rval,rfunc,{W->1u,L->1u}]


fig1=Plot[Evaluate[{xRsacc,xRsc}//.Join[rval,rfunc,{W->1u,L->1u}]],{Id,0,4m},PlotRange->{-50,1250},
FrameTicks->{xTicksProp[{0,4,0.5},{2,1},m],xTicksProp[{0,1.2,0.2},{2,1},k]},
PlotStyle->{Black,Gray},
PlotLegends->Placed[LineLegend[{
	xLaTeX["R_{acc}",0.7],
	xLaTeX["R_{contact}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMargins->0.3,
	LegendMarkerSize->{15,1}],{Left,Top}],
Evaluate@xFigLabel["I_d~(\\si{mA})","R~(\\si{k\\ohm})"],
Evaluate@xFigConfig]


fig={fig1}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
