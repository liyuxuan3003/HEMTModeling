#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter02F_01.fig.wls";
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
xEF=1;
xNOIA=-1.5 10^29;
xNOIB=1 10^32;
xNOIC=0.55 10^34;
(*xNOIA=-3.18 10^33;
xNOIB=2.24 10^34;
xNOIC=2.11 10^34;*)
xTNSC=1;


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
	EF->xEF,
	NOIA->xNOIA,
	NOIB->xNOIB,
	NOIC->xNOIC,
	TNSC->xTNSC
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


xmueff=mu0/(1+mua Eyeff+mub Eyeff^2);
xEyeff=Cg/epsi Abs[Vgo-psim];


xmueffsat=mueff/Sqrt[1+(mueff Ex/vsat)^2];
xEx=(psid-psis)/L;


xKr=L/((Vgo-psim+Vth)(psid-psis));
xQchd=Cg(Vgo-psid);
xQchs=Cg(Vgo-psis);


(*Sif flicker*)
(*Sit thermal*)


xSifInt=(kB T)/(W L^2 fx^EF) (Id^2 Kr)/(Cg^2)Integrate[((NOIA+NOIB Qch+NOIC Qch^2)(Vth Cg+Qch))/Qch^2,{Qch,Qchs,Qchd},Assumptions->{Qch>0,Qchs>0,Qchd>0,Qchd!=Qchs}]


xSif=(kB T)/(W L^2 fx^EF) (Id^2 Kr)/(Cg^2) (NOIA Vth Cg(1/Qchd-1/Qchs)+(NOIA+NOIB Vth Cg)Log[Qchd/Qchs]+(NOIB+NOIC Vth Cg)(-Qchd+Qchs)+NOIC/2 (Qchd^2-Qchs^2))


FullSimplify@xSifInt==FullSimplify@xSif


xSit=(4kB T)/(Id L^2) (mu W Cg)^2(Vgo^2(psid-psis)+(psid^3-psis^3)/3-Vgo(psid^2-psis^2));


rfunc={Vgo->xVgo,Vgef->xVgef,H->xH,Vgon->xVgon,Vgod->xVgod,Vgoeff->xVgoeff,Ef->xEf,
psi->xpsi,psid->xpsid,psis->xpsis,psim->xpsim,
Id->xId,mueff->xmueff,Eyeff->xEyeff,mueffsat->xmueffsat,Ex->xEx,
Kr->xKr,Qchd->xQchd,Qchs->xQchs,Sif->xSif,Sit->xSit
};


{Cg Vth,(-Qchd+Qchs),(1/Qchd-1/Qchs),((Qchd^2-Qchs^2)/2),Log[Qchd/Qchs]}//.Join[rval,rfunc,{W->1u,L->1u,Vg->2,Vd->1,Vs->0,mu->mueffsat}]


ff1={xSif}//.Join[rval,rfunc,{W->1u,L->1u,Vg->2,Vd->1,Vs->0,mu->mueffsat}];
LogLinearPlot[Evaluate@ff1,{fx,1,10^20},Evaluate@xFigConfig]


fSit3D=10^20 xSit//.Join[rval,rfunc,{W->1u,L->1u,Vs->0,mu->mueffsat}];
Plot3D[fSit3D,{Vd,0,5},{Vg,-5,5},Exclusions->Automatic,PlotPoints->100,Evaluate@xFig3DConfig]


fSitVg=Table[xSit//.Join[rval,rfunc,{W->1u,L->1u,Vs->0,mu->mueffsat}],{Vd,{1,2,4}}];
Plot[fSitVg,{Vg,-5,5},PlotPoints->200,Evaluate@xFigConfig]


fSitVd=Table[xSit//.Join[rval,rfunc,{W->1u,L->1u,Vs->0,mu->mueffsat}],{Vg,{0,1,2,4}}];
Plot[fSitVd,{Vd,0,5},PlotPoints->200,Evaluate@xFigConfig]


(*\:6781\:70b9\:53ef\:80fd\:662f1/Id\:9020\:6210\:7684*)


fig={}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
