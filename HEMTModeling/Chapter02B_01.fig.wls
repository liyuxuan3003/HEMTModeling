#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter02B_01.fig.wls";
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


xQg=(Cg L W)/(3(Vgo-psim+Vth))(
3Vgo^2+(psid^2+psis^2+psid psis)
-3Vgo(psid+psis-Vth)
-3Vth psim);


xQg


xQd=((Cg L W)/(120(Vgo-psim+Vth)^2))(
12psid^3+8psis^3+psis^2(16psid-5(5Vth+8Vgo))
+2psis(12psid^2-5psid(5Vth+8Vgo)+10(Vth+Vgo)(Vth+4Vgo))
-15psid^2(3Vth+4Vgo)-60Vgo (Vth+Vgo)^2
+20psid(Vth+Vgo)(2Vth+5Vgo));


xQs=-Qg-Qd;


fQga=FullSimplify[Integrate[W Cg(Vgo-psi) (L(Vgo-psi+Vth))/((Vgo-psim+Vth)(psid-psis)),{psi,psis,psid}]//.{psim->xpsim}]


fQgb=FullSimplify[xQg//.{psim->xpsim}]


fQga===fQgb


fx=FullSimplify@Integrate[(L(Vgo-px+Vth))/((Vgo-psim+Vth)(psid-psis)),{px,psis,psi}]


fQda=FullSimplify[-Integrate[(fx/L)W Cg(Vgo-psi) (L(Vgo-psi+Vth))/((Vgo-psim+Vth)(psid-psis)),{psi,psis,psid}]//.{psim->xpsim}]


fQdb=FullSimplify[xQd//.{psim->xpsim}]


fQda===fQdb


rfunc={Vgo->xVgo,Vgef->xVgef,H->xH,Vgon->xVgon,Vgod->xVgod,Vgoeff->xVgoeff,Ef->xEf,
psi->xpsi,psid->xpsid,psis->xpsis,psim->xpsim,
Qg->xQg,Qs->xQs,Qd->xQd};


fig1=Plot[Evaluate[{xQs,xQd,xQg}//.Join[rval,rfunc,{Vd->0,Vs->0,W->1u,L->1u}]],{Vg,-5,5},
PlotRange->{-0.03p,0.03p},PlotStyle->{Red,Blue,Black},
FrameTicks->{xTicks[{-5,5,1},{2,1}],xTicksProp[{-0.03,0.03,0.01},{3,2},p]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["Q_s",0.7],
	xLaTeX["Q_d",0.7],
	xLaTeX["Q_g",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",3},
	LegendLabel->xLaTeX["V_d=\\SI{0}{V}",0.7],
	LegendMargins->0.3,
	LegendMarkerSize->{22,1}],{Left,Bottom}],
Evaluate@xFigLabel["V_g~(\\si{V})","Q~(\\si{pC})"],
Evaluate@xFigConfig]


fig2=Plot[Evaluate[{xQs,xQd,xQg}//.Join[rval,rfunc,{Vd->1,Vs->0,W->1u,L->1u}]],{Vg,-5,5},
PlotRange->{-0.03p,0.03p},PlotStyle->{Red,Blue,Black},
FrameTicks->{xTicks[{-5,5,1},{2,1}],xTicksProp[{-0.03,0.03,0.01},{3,2},p]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["Q_s",0.7],
	xLaTeX["Q_d",0.7],
	xLaTeX["Q_g",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",3},
	LegendLabel->xLaTeX["V_d=\\SI{1}{V}",0.7],
	LegendMargins->0.3,
	LegendMarkerSize->{22,1}],{Right,Bottom}],
Evaluate@xFigLabel["V_g~(\\si{V})","Q~(\\si{pC})"],
Evaluate@xFigConfig]


fig3=Plot[Evaluate[Table[{xQs,xQd,xQg}//.Join[rval,rfunc,{Vs->0,W->1u,L->1u}],{Vg,{0}}]],{Vd,0,3},
PlotRange->{-0.03p,0.03p},
PlotStyle->(Nest[Lighter,#[[2]],#[[1]]]&)/@Flatten[Outer[List,{0,1,2},{Red,Blue,Black}],1],
FrameTicks->{xTicks[{0,3,0.5},{2,1}],xTicksProp[{-0.03,0.03,0.01},{3,2},p]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["Q_s",0.7],
	xLaTeX["Q_d",0.7],
	xLaTeX["Q_g",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",3},
	LegendLabel->xLaTeX["V_g=0\\si{V}",0.7],
	LegendMargins->0.3,
	LegendMarkerSize->{22,1}],{Left,Bottom}],
Evaluate@xFigLabel["V_d~(\\si{V})","Q~(\\si{pC})"],
Evaluate@xFigConfig]


fig4=Plot[Evaluate[Table[{xQs,xQd,xQg}//.Join[rval,rfunc,{Vs->0,W->1u,L->1u}],{Vg,{1}}]],{Vd,0,3},
PlotRange->{-0.03p,0.03p},
PlotStyle->(Nest[Lighter,#[[2]],#[[1]]]&)/@Flatten[Outer[List,{0,1,2},{Red,Blue,Black}],1],
FrameTicks->{xTicks[{0,3,0.5},{2,1}],xTicksProp[{-0.03,0.03,0.01},{3,2},p]},
PlotLegends->Placed[LineLegend[{
	xLaTeX["Q_s",0.7],
	xLaTeX["Q_d",0.7],
	xLaTeX["Q_g",0.7]},
	LegendFunction->"Panel",LegendLayout -> {"Column",3},
	LegendLabel->xLaTeX["V_g=1\\si{V}",0.7],
	LegendMargins->0.3,
	LegendMarkerSize->{22,1}],{Right,Bottom}],
Evaluate@xFigLabel["V_d~(\\si{V})","Q~(\\si{pC})"],
Evaluate@xFigConfig]


fig5=Plot3D[Evaluate[xQg//.Join[rval,rfunc,{Vs->0,W->1u,L->1u}]],{Vd,0,3},{Vg,-5,5},
PlotPoints->400,PlotRange->{-0.03p,0.03p},MaxRecursion->10,ViewPoint->{100,80,65},
Ticks->{xTicks[{0,3,0.5},{2,1}],xTicks[{-5,5,1},{2,1}],xTicksProp[{-0.03,0.03,0.01},{3,2},p]},
Filling->Bottom,
ColorFunctionScaling->False,
ColorFunction->(ColorData["DarkRainbow"][(#3+0.03p)/(0.06p)]&),
Mesh->{Table[x,{x,0,5,0.5}],Table[x,{x,-5,5,0.5}]},
Evaluate@xFig3DLabel["V_d~(\\si{V})","V_g~(\\si{V})","Q_g~(\\si{pC})"],
Evaluate@xFig3DConfig]


fig6=Plot3D[Evaluate[xQd//.Join[rval,rfunc,{Vs->0,W->1u,L->1u}]],{Vd,0,2},{Vg,-5,5},
PlotPoints->200,PlotRange->{-0.03p,0.03p},MaxRecursion->8,ViewPoint->{100,80,65},
Ticks->{xTicks[{0,3,0.5},{2,1}],xTicks[{-5,5,1},{2,1}],xTicksProp[{-0.03,0.03,0.01},{3,2},p]},
Filling->Bottom,
ColorFunctionScaling->False,
ColorFunction->(ColorData["DarkRainbow"][(#3+0.03p)/(0.06p)]&),
Mesh->{Table[x,{x,0,5,0.5}],Table[x,{x,-5,5,0.5}]},
Evaluate@xFig3DLabel["V_d~(\\si{V})","V_g~(\\si{V})","Q_d~(\\si{pC})"],
Evaluate@xFig3DConfig]


fig7=Plot3D[Evaluate[xQs//.Join[rval,rfunc,{Vs->0,W->1u,L->1u}]],{Vd,0,2},{Vg,-5,5},
PlotPoints->200,PlotRange->{-0.03p,0.03p},MaxRecursion->8,ViewPoint->{100,80,65},
Ticks->{xTicks[{0,3,0.5},{2,1}],xTicks[{-5,5,1},{2,1}],xTicksProp[{-0.03,0.03,0.01},{3,2},p]},
Filling->Bottom,
ColorFunctionScaling->False,
ColorFunction->(ColorData["DarkRainbow"][(#3+0.03p)/(0.06p)]&),
Mesh->{Table[x,{x,0,5,0.5}],Table[x,{x,-5,5,0.5}]},
Evaluate@xFig3DLabel["V_d~(\\si{V})","V_g~(\\si{V})","Q_s~(\\si{pC})"],
Evaluate@xFig3DConfig]


fig={fig1,fig2,fig3,fig4,fig5,fig6,fig7}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
