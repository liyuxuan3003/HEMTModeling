#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter01A_01.fig.wls";
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


xIr=Vr/(R(1+alpha dT));
xdTrise=Ir Vr Rth;


xIrise=Ir//.Solve[Ir==xIr/.{dT->dT+xdTrise},Ir][[2]]


Plot[Evaluate@Join[Table[xIr//.{R->1k,alpha->0.005},{dT,{0,40,80}}],{xIrise//.{R->1k,alpha->0.005,dT->0,Rth->1k}}],
{Vr,0,5},
PlotStyle->{Black,Directive[Gray,Dashed],Directive[Lighter[Gray],Dashed],Directive[Red,Thickness[0.003]]},
FrameTicks->{xTicks[{0,5,0.5},{2,1}],xTicksProp[{0,5,0.5},{2,1},m]},
PlotLegends->Placed[LineLegend[{
		xLaTeX["\\Delta{T}=0\\si{K}",0.7],
		xLaTeX["\\Delta{T}=40\\si{K}",0.7],
		xLaTeX["\\Delta{T}=80\\si{K}",0.7],
		xLaTeX["R_{th}=1\\si{k\\ohm},~\\Delta{T}=0\\si{K}",0.7]
	},
	LegendLabel->xLaTeX["R=1\\si{k\\ohm},~\\alpha=0.005",0.78],
	LegendMarkerSize->{{22,1}},
	LegendFunction->"Panel",
	LegendLayout -> {"Column",1}],{Left,Top}],
Evaluate@xFigLabel["V~(\\si{V})","I~(\\si{mA})"],
Evaluate@xFigConfig]


xIrise//.{R->1k,alpha->0.005,dT->0,Rth->2k}


Plot[xIrise//.{R->1k,alpha->0.005,dT->0,Rth->1k},{Vr,0,5},Evaluate@xFigConfig]


fig={}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
