#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter04B_01.fig.wls";
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
xmu0=170 10^-3;


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
	mu0->xmu0
};


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


xeqns1=DOS Vth(Log[Exp[(Ef-Ex[0])/Vth]+1]+Log[Exp[(Ef-Ex[1])/Vth]+1]);
xeqns2=epsi/(q tbar) (Vgo-Ef);
xEx[0]=gamma[0] ns^(2/3);
xEx[1]=gamma[1] ns^(2/3);
xeqns2=epsi/(q tbar) (Vgo-Ef);
xEf=Ef//.Solve[xeqns2==ns,{Ef}][[1]];


xpsi=Ef+Vx;
xpsid=Ef+Vd;
xpsis=Ef+Vs;
xpsim=(psid+psis)/2;


xIds=mu0 Cg(W/L)(Vgo-psim+Vth)(psid-psis);


ffIds=xIds//.{Vgo->xVgo,psim->xpsim,psid->xpsid,psis->xpsis,Ef->xEf,ns->xnuni,H->xH,Vgod->xVgod,Vgon->xVgon,Vgop->xVgop,W->1u,L->1u}//.rval;
Plot[Evaluate[Table[ffIds//.{Vs->0},{Vd,0,5,1}]],{Vg,-5,5},Evaluate@xFigConfig]
Plot[Evaluate[Table[ffIds//.{Vs->0},{Vg,0,5,1}]],{Vd,0,5},Evaluate@xFigConfig]





fig={}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
