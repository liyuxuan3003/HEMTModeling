#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter04A_01.fig.wls";
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
	alphad->xalphad
};


xeqns1=DOS Vth(Log[Exp[(Ef-Ex[0])/Vth]+1]+Log[Exp[(Ef-Ex[1])/Vth]+1]);
xeqns2=epsi/(q tbar) (Vgo-Ef-Vx);
xEx[0]=gamma[0] ns^(2/3);
xEx[1]=gamma[1] ns^(2/3);
xEf=Ef//.Solve[xeqns2==ns,{Ef}][[1]];


xH=Function[{Vgo},(Vgo+Vth(1-Log[beta Vgon[Vgo]])-(gamma[0]/3)(Cg Vgo/q)^(2/3))/(Vgo(1+Vth/Vgod[Vgo])+(2gamma[0]/3)(Cg Vgo/q)^(2/3))];
xVgon=Function[{Vgo},(Vgo alphan)/Sqrt[Vgo^2+alphan^2]];
xVgod=Function[{Vgo},(Vgo alphad)/Sqrt[Vgo^2+alphad^2]];
xVgosep=Vgo//.FindRoot[FullSimplify[{xH'[Vgo]==0}//.Join[rval,{H->xH,Vgon->xVgon,Vgod->xVgod}]],{Vgo,0.4}];


xVgo=Vg-Voff;
xVgef=Vg-Voff-Ef;
xVgop=Piecewise[{{Vgo,Vgo>xVgosep},{xVgosep,Vgo<=xVgosep}}];


xnsub=2 DOS Vth Exp[Vgo/Vth];
xnabo=(Cg Vgo)/q H[Vgo];
xnuni=(2Vth Cg/q Log[1+Exp[Vgo/(2Vth)]])/(1/H[Vgop]+(Cg/(q DOS))Exp[-Vgo/(2Vth)]);


xkx=(gamma[#](Cg/q)^(2/3))&;
xxi=(Exp[(Ef-kx[#]Vgef^(2/3))/Vth])&;
xpx=+(Cg/q)Vgef-Sum[DOS Vth Log[xi[i]+1],{i,{0,1}}];
xqx=-(Cg/q)-Sum[DOS/(1+xi[i]^-1) (1+2/3 kx[i]Vgef^(-1/3)),{i,{0,1}}];
xrx=Sum[1/(1+xi[i]^-1) (2/9 Vgef^(-4/3)DOS kx[i](1+xi[i]^-1)+DOS/Vth (1+2/3 kx[i]Vgef^(-1/3))^2),{i,{0,1}}];


xEfext=Ef-px/qx (1+(px rx)/(2qx^2));


func1=Evaluate[xH[Vgo]//.Join[rval,{H->xH,Vgon->xVgon,Vgod->xVgod}]];
fig1=Plot[func1,{Vgo,0,3},
PlotPoints->1000,MaxRecursion->5,PlotRange->{0.74,1.01},PlotStyle->{Black},
FrameTicks->{xTicks[{0,3,0.5},{2,1}],xTicks[{0.75,1,0.05},{3,2}]},
GridLines->{xGrids[{0,3,0.1}],xGrids[{0.75,1,0.01}]},
Epilog->{
	PointSize[0.015],Point[{xVgosep,func1//.{Vgo->xVgosep}}],
	PointSize[0.010],White,Point[{xVgosep,func1//.{Vgo->xVgosep}}]
},
Evaluate@xFigLabel["V_{go}","H(Vgo)"],
Evaluate@xFigConfig]


func2=Evaluate[{xH'[Vgo]}//.Join[rval,{H->xH,Vgon->xVgon,Vgod->xVgod}]];
fig2=Plot[func2,{Vgo,0,3},
PlotPoints->1000,MaxRecursion->5,PlotRange->{-0.045,0.045},PlotStyle->{Black},
FrameTicks->{xTicks[{0,3,0.5},{2,1}],xTicks[{-0.04,0.04,0.01},{3,2}]},
GridLines->{xGrids[{0,3,0.1}],xGrids[{-0.04,0.04,0.005}]},
Epilog->{
	PointSize[0.015],Point[{xVgosep,0}],
	PointSize[0.010],White,Point[{xVgosep,0}]
},
Evaluate@xFigLabel["V_{go}","H'(Vgo)"],
Evaluate@xFigConfig]


fig3=LogPlot[Evaluate[{xnuni,xnsub,xnabo}//.Join[rval,{H->xH,Vgon->xVgon,Vgod->xVgod,Vgop->xVgop,Vgo->Vg-Voff}]],{Vg,-3,3},
PlotPoints->1000,MaxRecursion->5,PlotRange->{Sqrt[2]/2 10^13,Sqrt[2] 10^18},Axes->None,
FrameTicks->{xTicks[{-3,3,0.5},{2,1}],xTicksLog[{13,18,1}]},
GridLines->{xGrids[{-3,3,0.1}],xGridsLog[{13,18,1},{10^13,10^18}]},
PlotStyle->{Black,Directive[Lighter[Blue],Thickness[0.003]],Directive[Lighter[Red],Thickness[0.003]]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["n_{s}~V_g<V_{off}",0.8],
	xLaTeX["n_{s}~V_g>V_{off}",0.8],
	xLaTeX["n_{s}",0.8]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMarkerSize->{22,1}],{Right,Bottom}],
Evaluate@xFigLabel["V_{g}","n_s~(\\si{m^{-3}})"],
Prolog->{Black,Dashed,Thickness[0.001],Line[{{xVoff,Log[10^12]},{xVoff,Log[10^19]}}],Text[xLaTeX["V_{off}",0.8],{-2.25,Log[3 10^17]}]},
Evaluate@xFigConfig]


fig4=Plot[Evaluate[{xEf,xEx[0],xEx[1]}//.Join[rval,{
	H->xH,Vgon->xVgon,Vgod->xVgod,Vgop->xVgop,Vgo->Vg-Voff,
	ns->xnuni,Vx->0}]],{Vg,-3,3},
PlotPoints->1000,MaxRecursion->5,PlotRange->{-0.45,1.05},PlotStyle->{Black,Blue,Red},Axes->None,
FrameTicks->{xTicks[{-3,3,0.5},{2,1}],xTicks[{-0.4,1.0,0.2},{2,1}]},
GridLines->{xGrids[{-3,3,0.1}],xGrids[{-0.4,1.0,0.1}]},
PlotStyle->{Black,Directive[Lighter[Blue],Thickness[0.003]],Directive[Lighter[Red],Thickness[0.003]]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["E_{f}",0.8],
	xLaTeX["E_{0}",0.8],
	xLaTeX["E_{1}",0.8]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMarkerSize->{22,1}],{Right,Bottom}],
Evaluate@xFigLabel["V_{g}","E_f~(\\si{eV})"],
Prolog->{Black,Dashed,Thickness[0.001],Line[{{xVoff,-0.5},{xVoff,1.1}}],Text[xLaTeX["V_{off}",0.8],{-2.25,0.85}]},
Evaluate@xFigConfig]


fig5=Plot[Evaluate[{xEf,xEfext}//.Join[rval,{
	H->xH,Vgon->xVgon,Vgod->xVgod,Vgop->xVgop,Vgo->Vg-Voff,Vgef->xVgef,Ef->xEf,
	ns->xnuni,Vx->0,
	kx->xkx,xi->xxi,px->xpx,qx->xqx,rx->xrx}]],{Vg,-3,3},
PlotPoints->1000,MaxRecursion->5,PlotRange->{-0.45,1.05},PlotStyle->{Black,Directive[Lighter[Red],Dashed,Thickness[0.005]]},Axes->None,
FrameTicks->{xTicks[{-3,3,0.5},{2,1}],xTicks[{-0.4,1.0,0.2},{2,1}]},
GridLines->{xGrids[{-3,3,0.1}],xGrids[{-0.4,1.0,0.1}]},
PlotStyle->{Black,Directive[Lighter[Blue],Thickness[0.003]],Directive[Lighter[Lighter[Red]],Thickness[0.0025]]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["E_{f}",0.8],
	xLaTeX["E_{f,acc}",0.8]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMarkerSize->{22,1}],{Right,Bottom}],
Evaluate@xFigLabel["V_{g}","E_f~(\\si{eV})"],
Prolog->{Black,Dashed,Thickness[0.001],Line[{{xVoff,-0.5},{xVoff,1.1}}],Text[xLaTeX["V_{off}",0.8],{-2.25,0.85}]},
Evaluate@xFigConfig]


fig6=Plot[Evaluate[{xEfext-xEf}//.Join[rval,{
	H->xH,Vgon->xVgon,Vgod->xVgod,Vgop->xVgop,Vgo->Vg-Voff,Vgef->xVgef,Ef->xEf,
	ns->xnuni,Vx->0,
	kx->xkx,xi->xxi,px->xpx,qx->xqx,rx->xrx}]],{Vg,-3,3},
PlotPoints->2000,MaxRecursion->5,PlotRange->{-0.0085,0.0045},PlotStyle->{Black},Axes->None,
FrameTicks->{xTicks[{-3,3,0.5},{2,1}],xTicks[{-0.008,0.004,0.002},{4,3}]},
GridLines->{xGrids[{-3,3,0.1}],xGrids[{-0.008,0.004,0.001}]},
PlotStyle->{Black,Directive[Lighter[Blue],Thickness[0.003]],Directive[Lighter[Lighter[Red]],Thickness[0.0025]]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["E_{f}",0.8],
	xLaTeX["E_{f,acc}",0.8]},
	LegendFunction->"Panel",LegendLayout -> {"Column",1},
	LegendMarkerSize->{22,1}],{Right,Bottom}],
Evaluate@xFigLabel["V_{g}","E_f~(\\si{eV})"],
Prolog->{Black,Dashed,Thickness[0.001],Line[{{xVoff,-0.5},{xVoff,1.1}}],Text[xLaTeX["V_{off}",0.8],{-2.25,0.85}]},
Evaluate@xFigConfig]


fig={fig1,fig2,fig3,fig4,fig5,fig6}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
