#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter02C_01.fig.wls";
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
	VDSCALE->xVDSCALE
};


xns=Cg/q (Vgo-Ef-Vx);


xVgo=Vg-Voff;
xVgef=Vg-Voff-Ef;
xH=Function[{Vgo},(Vgo+Vth(1-Log[beta Vgon[Vgo]])-(gamma[0]/3)(Cg Vgo/q)^(2/3))/(Vgo(1+Vth/Vgod[Vgo])+(2gamma[0]/3)(Cg Vgo/q)^(2/3))];
xVgon=Function[{Vgo},(Vgo alphan)/Sqrt[Vgo^2+alphan^2]];
xVgod=Function[{Vgo},(Vgo alphad)/Sqrt[Vgo^2+alphad^2]];
xVgoeff=1/2 (Vgo+Sqrt[Vgo^2+4ep^2]);


xEf=Vgo-(2Vth Log[1+Exp[Vgo/(2Vth)]])/(1/H[Vgoeff]+(Cg/(q DOS))Exp[-Vgo/(2Vth)]);


xpsi=Ef+Vx;
xpsid=Ef+Vd;
xpsis=Ef+Vs;
xpsim=(psid+psis)/2;


xId=W/L mu Cg(Vgo-psim+Vth)(psid-psis);


xIdclm=Id(1+lambda(Vdsx-Vdseff));


xVdsx=Sqrt[Vds^2+0.01];
xVdseff=Vds (1+(Vds/Vdsat)^(delta))^(-1/delta);
xVdsat=(2(vsat/mu)L Vgoeff)/(2(vsat/mu)L+Vgoeff);
xVds=Vd-Vs;


xmueff=mu0/(1+mua Eyeff+mub Eyeff^2);
xEyeff=Cg/epsi Abs[Vgo-psim];


xmueffsat=mueff/Sqrt[1+(mueff Ex/vsat)^2];
xEx=(psid-psis)/L;


xVoffDIBL=Voff-(eta0) (Vdsx VDSCALE)/Sqrt[Vdsx^2+VDSCALE^2];


rfunc={Vgo->xVgo,Vgef->xVgef,H->xH,Vgon->xVgon,Vgod->xVgod,Vgoeff->xVgoeff,Ef->xEf,
psi->xpsi,psid->xpsid,psis->xpsis,psim->xpsim,
Id->xId,mueff->xmueff,Eyeff->xEyeff,mueffsat->xmueffsat,Ex->xEx,
Idclm->xId,Vdsx->xVdsx,Vdseff->xVdseff,Vdsat->xVdsat,Vds->xVds
};


fig1func=xId//.Join[rval,rfunc,{W->1u,L->1u,Vs->0,mu->mu0}];


fig1a=Plot[Evaluate[Table[fig1func,{Vd,{0,1,2,3,4,5}}]],{Vg,-5,5},
PlotRange->{-11m,16m},Axes->None,
FrameTicks->{xTicks[{-5,5,1},{2,1}],xTicksProp[{-10,15,5},{2,1},m]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["V_d=0\\si{V}",0.7],
	xLaTeX["V_d=1\\si{V}",0.7],
	xLaTeX["V_d=2\\si{V}",0.7],
	xLaTeX["V_d=3\\si{V}",0.7],
	xLaTeX["V_d=4\\si{V}",0.7],
	xLaTeX["V_d=5\\si{V}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",3},
	LegendLabel->xLaTeX["\\mu=\\mu_{0}",0.7],
	LegendMargins->0.3,
	LegendMarkerSize->{15,1}],{Left,Top}],
Evaluate@xFigLabel["V_{g}~(\\si{V})","I_d~(\\si{mA})"],
Evaluate@xFigConfig]


fig1b=Plot[Evaluate[Table[fig1func,{Vg,{0,1,2,3,4,5}}]],{Vd,0,5},
PlotRange->{-11m,16m},Axes->None,
FrameTicks->{xTicks[{0,5,1},{2,1}],xTicksProp[{-10,15,5},{2,1},m]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["V_g=0\\si{V}",0.7],
	xLaTeX["V_g=1\\si{V}",0.7],
	xLaTeX["V_g=2\\si{V}",0.7],
	xLaTeX["V_g=3\\si{V}",0.7],
	xLaTeX["V_g=4\\si{V}",0.7],
	xLaTeX["V_g=5\\si{V}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",3},
	LegendLabel->xLaTeX["\\mu=\\mu_{0}",0.7],
	LegendMargins->0.3,
	LegendMarkerSize->{15,1}],{Left,Bottom}],
Evaluate@xFigLabel["V_{d}~(\\si{V})","I_d~(\\si{mA})"],
Evaluate@xFigConfig]


fig1c=Plot3D[fig1func,{Vd,0,5},{Vg,-5,5},
PlotPoints->100,
PlotRange->{-10m,15m},Filling->Bottom,
Mesh->{Table[x,{x,0,5,0.5}],Table[x,{x,-5,5,0.5}]},
Ticks->{xTicks[{0,5,1},{2,1}],xTicks[{-5,5,1},{2,1}],xTicksProp[{-10,15,5},{2,1},m]},
Evaluate@xFig3DLabel["V_{d}~(\\si{V})","V_{g}~(\\si{V})","I_d~(\\si{mA})"],
Evaluate@xFig3DConfig]


colList=Table[ColorData[10][[4]][x],{x,1,6,1}];
colPairList=(Directive[#[[1]],#[[2]]]&)/@Flatten[Outer[List,{None,Dashed},colList],1];


fig2func1=xId//.Join[rval,rfunc,{W->1u,L->1u,Vs->0,mu->mu0}];
fig2func2=xId//.Join[rval,rfunc,{W->1u,L->1u,Vs->0,mu->mueff}];


fig2a=Plot[Evaluate[(Table[#,{Vd,{0,1,2,3,4,5}}])&/@{fig2func1,fig2func2}],{Vg,-5,5},
PlotRange->{-11m,16m},Axes->None,
PlotStyle->colPairList,
FrameTicks->{xTicks[{-5,5,1},{2,1}],xTicksProp[{-10,15,5},{2,1},m]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["V_d=0\\si{V}",0.7],
	xLaTeX["V_d=1\\si{V}",0.7],
	xLaTeX["V_d=2\\si{V}",0.7],
	xLaTeX["V_d=3\\si{V}",0.7],
	xLaTeX["V_d=4\\si{V}",0.7],
	xLaTeX["V_d=5\\si{V}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",3},
	LegendLabel->xLaTeX["\\mu=\\mu_{0},\\mu_{eff}",0.7],
	LegendMargins->0.3,
	LegendMarkerSize->{15,1}],{Left,Top}],
Evaluate@xFigLabel["V_{g}~(\\si{V})","I_d~(\\si{mA})"],
Evaluate@xFigConfig]


fig2b=Plot[Evaluate[(Table[#,{Vg,{0,1,2,3,4,5}}])&/@{fig2func1,fig2func2}],{Vd,0,5},
PlotRange->{-11m,16m},Axes->None,
PlotStyle->colPairList,
FrameTicks->{xTicks[{0,5,1},{2,1}],xTicksProp[{-10,15,5},{2,1},m]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["V_g=0\\si{V}",0.7],
	xLaTeX["V_g=1\\si{V}",0.7],
	xLaTeX["V_g=2\\si{V}",0.7],
	xLaTeX["V_g=3\\si{V}",0.7],
	xLaTeX["V_g=4\\si{V}",0.7],
	xLaTeX["V_g=5\\si{V}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",3},
	LegendLabel->xLaTeX["\\mu=\\mu_{0},\\mu_{eff}",0.7],
	LegendMargins->0.3,
	LegendMarkerSize->{15,1}],{Left,Bottom}],
Evaluate@xFigLabel["V_{d}~(\\si{V})","I_d~(\\si{mA})"],
Evaluate@xFigConfig]


fig3func=xId//.Join[rval,rfunc,{W->1u,L->1u,Vs->0,mu->mueffsat}];


fig3a=Plot[Evaluate[Table[fig3func,{Vd,{0,1,2,3,4,5}}]],{Vg,-5,5},
PlotRange->{-2.4m,4.4m},Axes->None,
FrameTicks->{xTicks[{-5,5,1},{2,1}],xTicksProp[{-3,4,1},{2,1},m]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["V_d=0\\si{V}",0.7],
	xLaTeX["V_d=1\\si{V}",0.7],
	xLaTeX["V_d=2\\si{V}",0.7],
	xLaTeX["V_d=3\\si{V}",0.7],
	xLaTeX["V_d=4\\si{V}",0.7],
	xLaTeX["V_d=5\\si{V}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",3},
	LegendLabel->xLaTeX["\\mu=\\mu_{sat}",0.7],
	LegendMargins->0.3,
	LegendMarkerSize->{17,1}],{Left,Top}],
Evaluate@xFigLabel["V_{g}~(\\si{V})","I_d~(\\si{mA})"],
Evaluate@xFigConfig]


fig3b=Plot[Evaluate[Table[fig3func,{Vg,{0,1,2,3,4,5}}]],{Vd,0,5},
PlotRange->{-2.4m,4.4m},Axes->None,
FrameTicks->{xTicks[{0,5,1},{2,1}],xTicksProp[{-2,4,1},{2,1},m]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["V_g=0\\si{V}",0.7],
	xLaTeX["V_g=1\\si{V}",0.7],
	xLaTeX["V_g=2\\si{V}",0.7],
	xLaTeX["V_g=3\\si{V}",0.7],
	xLaTeX["V_g=4\\si{V}",0.7],
	xLaTeX["V_g=5\\si{V}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",3},
	LegendMargins->0.3,
	LegendLabel->xLaTeX["\\mu=\\mu_{sat}",0.7],
	LegendMarkerSize->{15,1}],{Left,Bottom}],
Evaluate@xFigLabel["V_{d}~(\\si{V})","I_d~(\\si{mA})"],
Evaluate@xFigConfig]


fig3c=Plot3D[fig3func,{Vd,0,5},{Vg,-5,5},
PlotPoints->100,
PlotRange->{-2m,4m},Filling->Bottom,
Ticks->{xTicks[{0,5,1},{2,1}],xTicks[{-5,5,1},{2,1}],xTicksProp[{-2,4,1},{2,1},m]},
Mesh->{Table[x,{x,0,5,0.5}],Table[x,{x,-5,5,0.5}]},
Evaluate@xFig3DLabel["V_{d}~(\\si{V})","V_{g}~(\\si{V})","I_d~(\\si{mA})"],
Evaluate@xFig3DConfig]


fig4func=Evaluate[-xmueff//.Join[rval,rfunc,{Vs->0}]];
fig4=Plot3D[fig4func,{Vd,0,5},{Vg,-5,5},
PlotRange->{-0.17,-0.03},Filling->Bottom,PlotPoints->200,
Ticks->{xTicks[{0,5,1},{2,1}],xTicks[{-5,5,1},{2,1}],Join[xTicksProp[{0.05,0.15,0.05},{3,2},-1],xTicksProp[{0.17,0.17,1},{3,2},-1]]},
Mesh->{Table[x,{x,0,5,0.5}],Table[x,{x,-5,5,0.5}]},
ImageSize->400,
Evaluate@xFig3DLabel["V_{d}~(\\si{V})","V_{g}~(\\si{V})","\\mu_{eff}~(\\si{m^2\\cdot V^{-1}\\cdot s^{-1}})"],
Evaluate@xFig3DConfig]


fig5func=Evaluate[-xmueffsat//.Join[rval,rfunc,{Vs->0,W->1u,L->1u}]];
fig5=Plot3D[fig5func,{Vd,0,5},{Vg,-5,5},
PlotRange->{-0.17,-0.03},Filling->Bottom,PlotPoints->400,
Ticks->{xTicks[{0,5,1},{2,1}],xTicks[{-5,5,1},{2,1}],Join[xTicksProp[{0.05,0.15,0.05},{3,2},-1],xTicksProp[{0.17,0.17,1},{3,2},-1]]},
Mesh->{Table[x,{x,0,5,0.5}],Table[x,{x,-5,5,0.5}]},
ImageSize->400,
Evaluate@xFig3DLabel["V_{d}~(\\si{V})","V_{g}~(\\si{V})","\\mu_{sat}~(\\si{m^2\\cdot V^{-1}\\cdot s^{-1}})"],
Evaluate@xFig3DConfig]


fig6func1=xId//.Join[rval,rfunc,{W->1u,L->1u,Vs->0,mu->mueffsat}];
fig6func2=xIdclm//.Join[rval,rfunc,{W->1u,L->1u,Vs->0,mu->mueffsat}];


fig6a=Plot[Evaluate[(Table[#,{Vd,{0,1,2,3,4,5}}])&/@{fig6func1,fig6func2}],{Vg,-5,5},
PlotRange->{-2.4m,4.4m},Axes->None,
PlotStyle->colPairList,
FrameTicks->{xTicks[{-5,5,1},{2,1}],xTicksProp[{-3,4,1},{2,1},m]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["V_d=0\\si{V}",0.7],
	xLaTeX["V_d=1\\si{V}",0.7],
	xLaTeX["V_d=2\\si{V}",0.7],
	xLaTeX["V_d=3\\si{V}",0.7],
	xLaTeX["V_d=4\\si{V}",0.7],
	xLaTeX["V_d=5\\si{V}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",3},
	LegendLabel->xLaTeX["\\mu=\\mu_{sat}",0.7],
	LegendMargins->0.3,
	LegendMarkerSize->{15,1}],{Left,Top}],
Evaluate@xFigLabel["V_{g}~(\\si{V})","I_d,I_{d,CLM}~(\\si{mA})"],
Evaluate@xFigConfig]


fig6b=Plot[Evaluate[(Table[#,{Vg,{0,1,2,3,4,5}}])&/@{fig6func1,fig6func2}],{Vd,0,5},
PlotRange->{-2.4m,4.4m},Axes->None,
PlotStyle->colPairList,
FrameTicks->{xTicks[{0,5,1},{2,1}],xTicksProp[{-3,4,1},{2,1},m]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["V_g=0\\si{V}",0.7],
	xLaTeX["V_g=1\\si{V}",0.7],
	xLaTeX["V_g=2\\si{V}",0.7],
	xLaTeX["V_g=3\\si{V}",0.7],
	xLaTeX["V_g=4\\si{V}",0.7],
	xLaTeX["V_g=5\\si{V}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",3},
	LegendLabel->xLaTeX["\\mu=\\mu_{sat}",0.7],
	LegendMargins->0.3,
	LegendMarkerSize->{15,1}],{Left,Bottom}],
Evaluate@xFigLabel["V_{d}~(\\si{V})","I_d,I_{d,CLM}~(\\si{mA})"],
Evaluate@xFigConfig]


fig7func//.{Vd->0}


fig7func=xVoffDIBL//.Join[rval,rfunc,{Vs->0,W->1u,L->1u}];
fig7a=Plot[Evaluate[{xVoff,fig7func}],{Vd,0,5},PlotStyle->{Black,Directive[Black,Dashed]},PlotRange->{-2.0055,-1.9995},
FrameTicks->{xTicks[{0,5,1},{2,1}],xTicks[{-2.005,-2,0.001},{4,3}]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["V_{off}",0.7],
	xLaTeX["V_{off,DIBL}",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMargins->0.3,
	LegendMarkerSize->{15,1}],{Left,Bottom}],
Evaluate@xFigLabel["V_{d}~(\\si{V})","V_{off},V_{off,DIBL}~(\\si{V})"],
Evaluate@xFigConfig]


fig={fig1a,fig1b,fig1c,fig2a,fig2b,fig3a,fig3b,fig3c,fig4,fig5,fig6a,fig6b,fig7a}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
