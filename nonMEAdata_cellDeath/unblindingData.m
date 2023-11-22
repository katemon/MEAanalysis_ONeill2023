%%
clc; clear all; close all;

dataLoc = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\MEA papers -- addl experiments\EXP for BDNF + glu\Glutamate cell death, BDNF treatment\v3 (final) of analysis\';
%
% load([dataLoc,'cellDeathPixelData.mat']);
% load([dataLoc,'cellDeathNucleiData_blindUnblind.mat']);
%
% blindedPixData = pixData;
% blindedBranchData = bpData;
%
% %% PIXELS -- replicate 1
%
% unblindedPixData.repl1.cond30g50b_24h.rpt1 = blindedPixData.repl1.Aquamarine.Aquamarine1;      %Aquamarine ... 24 hours 30g + 50b
% unblindedPixData.repl1.cond30g50b_24h.rpt2 = blindedPixData.repl1.Aquamarine.Aquamarine2;
% unblindedPixData.repl1.cond30g50b_24h.rpt3 = blindedPixData.repl1.Aquamarine.Aquamarine3;
%
% unblindedPixData.repl1.cond0g50b_24h.rpt1 = blindedPixData.repl1.Black.Black1;                  %Black ... 24 hours 0g + 50b
% unblindedPixData.repl1.cond0g50b_24h.rpt2 = blindedPixData.repl1.Black.Black2;
% unblindedPixData.repl1.cond0g50b_24h.rpt3 = blindedPixData.repl1.Black.Black3;
%
% unblindedPixData.repl1.cond30g50b_72h.rpt1 = blindedPixData.repl1.Blue.Blue1;                   %Blue ... 72 hours 30 g + 50b
% unblindedPixData.repl1.cond30g50b_72h.rpt2 = blindedPixData.repl1.Blue.Blue2;
% unblindedPixData.repl1.cond30g50b_72h.rpt3 = blindedPixData.repl1.Blue.Blue3;
%
% unblindedPixData.repl1.cond30g0b_24h.rpt1 = blindedPixData.repl1.Green.Green1;                  %Green ... 24 hours 30g + 0b
% unblindedPixData.repl1.cond30g0b_24h.rpt2 = blindedPixData.repl1.Green.Green2;
% unblindedPixData.repl1.cond30g0b_24h.rpt3 = blindedPixData.repl1.Green.Green3;
%
% unblindedPixData.repl1.cond30g0b_72h.rpt1 = blindedPixData.repl1.Grey.Grey1;                    %Gray ... 72 hours 30g +0b
% unblindedPixData.repl1.cond30g0b_72h.rpt2 = blindedPixData.repl1.Grey.Grey2;
% unblindedPixData.repl1.cond30g0b_72h.rpt3 = blindedPixData.repl1.Grey.Grey3;
%
% unblindedPixData.repl1.cond0g0b_72h.rpt1 = blindedPixData.repl1.Maroon.Maroon1;                 %Maroon ... 72 hours 0g +0b
% unblindedPixData.repl1.cond0g0b_72h.rpt2 = blindedPixData.repl1.Maroon.Maroon2;
% unblindedPixData.repl1.cond0g0b_72h.rpt3 = blindedPixData.repl1.Maroon.Maroon3;
%
% unblindedPixData.repl1.cond0g0b_24h.rpt1 = blindedPixData.repl1.Orange.Orange1;                 %Orange ... 24h 0g +0b
% unblindedPixData.repl1.cond0g0b_24h.rpt2 = blindedPixData.repl1.Orange.Orange2;
% unblindedPixData.repl1.cond0g0b_24h.rpt3 = blindedPixData.repl1.Orange.Orange3;
%
% unblindedPixData.repl1.cond0g50b_72h.rpt1 = blindedPixData.repl1.Purple.Purple1;                %Purple ... 72 hours 0g +50b
% unblindedPixData.repl1.cond0g50b_72h.rpt2 = blindedPixData.repl1.Purple.Purple2;
% unblindedPixData.repl1.cond0g50b_72h.rpt3 = blindedPixData.repl1.Purple.Purple3;
%
% unblindedPixData.repl1.cond0g0b_0h.rpt1 = blindedPixData.repl1.Teal.Teal1;                      %Teal ... 0h 0g + nob
% unblindedPixData.repl1.cond0g0b_0h.rpt2 = blindedPixData.repl1.Teal.Teal2;
% unblindedPixData.repl1.cond0g0b_0h.rpt3 = blindedPixData.repl1.Teal.Teal3;
%
% unblindedPixData.repl1.cond30g0b_0h.rpt1 = blindedPixData.repl1.Violet.Violet1;                 %Violet ... 0h 30g + no b
% unblindedPixData.repl1.cond30g0b_0h.rpt2 = blindedPixData.repl1.Violet.Violet2;
% unblindedPixData.repl1.cond30g0b_0h.rpt3 = blindedPixData.repl1.Violet.Violet3;
%
% unblindedPixData.repl1.pre.rpt1 = blindedPixData.repl1.White.White1;                            %White ... pre - injury
% unblindedPixData.repl1.pre.rpt2 = blindedPixData.repl1.White.White2;
% unblindedPixData.repl1.pre.rpt3 = blindedPixData.repl1.White.White3;
%
%
% %% PIXELS -- replicate 2
%
% unblindedPixData.repl2.cond30g50b_24h.rpt1 = blindedPixData.repl2.Ukraine.Ukraine1;     %Ukraine ... 24 hours 30g + 50b
% unblindedPixData.repl2.cond30g50b_24h.rpt2 = blindedPixData.repl2.Ukraine.Ukraine2;
% unblindedPixData.repl2.cond30g50b_24h.rpt3 = blindedPixData.repl2.Ukraine.Ukraine3;
%
% unblindedPixData.repl2.cond0g50b_24h.rpt1 = blindedPixData.repl2.India.India1;          %India ... 24 hours 0g + 50b
% unblindedPixData.repl2.cond0g50b_24h.rpt2 = blindedPixData.repl2.India.India2;
% unblindedPixData.repl2.cond0g50b_24h.rpt3 = blindedPixData.repl2.India.India3;
%
% unblindedPixData.repl2.cond30g50b_72h.rpt1 = blindedPixData.repl2.Croatia.Croatia1;     %Croatia ... 72 hours 30 g + 50b
% unblindedPixData.repl2.cond30g50b_72h.rpt2 = blindedPixData.repl2.Croatia.Croatia2;
% unblindedPixData.repl2.cond30g50b_72h.rpt3 = blindedPixData.repl2.Croatia.Croatia3;
%
% unblindedPixData.repl2.cond30g0b_24h.rpt1 = blindedPixData.repl2.Italy.Italy1;          %Italy ... 24 hours 30g + 0b
% unblindedPixData.repl2.cond30g0b_24h.rpt2 = blindedPixData.repl2.Italy.Italy2;
% unblindedPixData.repl2.cond30g0b_24h.rpt3 = blindedPixData.repl2.Italy.Italy3;
%
% unblindedPixData.repl2.cond30g0b_72h.rpt1 = blindedPixData.repl2.Germany.Germany1;      %Germany ... 72 hours 30g +0b
% unblindedPixData.repl2.cond30g0b_72h.rpt2 = blindedPixData.repl2.Germany.Germany2;
% unblindedPixData.repl2.cond30g0b_72h.rpt3 = blindedPixData.repl2.Germany.Germany3;
%
% unblindedPixData.repl2.cond0g0b_72h.rpt1 = blindedPixData.repl2.France.France1;         %France ... 72 hours 0g +0b
% unblindedPixData.repl2.cond0g0b_72h.rpt2 = blindedPixData.repl2.France.France2;
% unblindedPixData.repl2.cond0g0b_72h.rpt3 = blindedPixData.repl2.France.France3;
%
% unblindedPixData.repl2.cond0g0b_24h.rpt1 = blindedPixData.repl2.Mexico.Mexico1;         %Mexico ... 24h 0g +0b
% unblindedPixData.repl2.cond0g0b_24h.rpt2 = blindedPixData.repl2.Mexico.Mexico2;
% unblindedPixData.repl2.cond0g0b_24h.rpt3 = blindedPixData.repl2.Mexico.Mexico3;
%
% unblindedPixData.repl2.cond0g50b_72h.rpt1 = blindedPixData.repl2.Spain.Spain1;          %Spain ... 72 hours 0g +50b
% unblindedPixData.repl2.cond0g50b_72h.rpt2 = blindedPixData.repl2.Spain.Spain2;
%
% unblindedPixData.repl2.cond0g0b_0h.rpt1 = blindedPixData.repl2.USA.USA1;                %USA ... 0h 0g + nob
% unblindedPixData.repl2.cond0g0b_0h.rpt2 = blindedPixData.repl2.USA.USA2;
% unblindedPixData.repl2.cond0g0b_0h.rpt3 = blindedPixData.repl2.USA.USA3;
%
% unblindedPixData.repl2.cond30g0b_0h.rpt1 = blindedPixData.repl2.China.China1;           %China ... 0h 30g + no b
% unblindedPixData.repl2.cond30g0b_0h.rpt2 = blindedPixData.repl2.China.China2;
% unblindedPixData.repl2.cond30g0b_0h.rpt3 = blindedPixData.repl2.China.China3;
%
% unblindedPixData.repl2.pre.rpt1 = blindedPixData.repl2.Russia.Russia1;                  %Russia ... pre - injury
% unblindedPixData.repl2.pre.rpt2 = blindedPixData.repl2.Russia.Russia2;
% unblindedPixData.repl2.pre.rpt3 = blindedPixData.repl2.Russia.Russia3;
%
%
% %% PIXELS -- replicate 3
%
% unblindedPixData.repl3.cond30g50b_24h.rpt1 = blindedPixData.repl3.Phoenix.Phoenix1;             %Phoenix ... 24 hours 30g + 50b
% unblindedPixData.repl3.cond30g50b_24h.rpt2 = blindedPixData.repl3.Phoenix.Phoenix2;
% unblindedPixData.repl3.cond30g50b_24h.rpt3 = blindedPixData.repl3.Phoenix.Phoenix3;
%
% unblindedPixData.repl3.cond0g50b_24h.rpt1 = blindedPixData.repl3.Detroit.Detroit1;              %Detroit ... 24 hours 0g + 50b
% unblindedPixData.repl3.cond0g50b_24h.rpt2 = blindedPixData.repl3.Detroit.Detroit2;
% unblindedPixData.repl3.cond0g50b_24h.rpt3 = blindedPixData.repl3.Detroit.Detroit3;
%
% unblindedPixData.repl3.cond30g50b_72h.rpt1 = blindedPixData.repl3.Miami.Miami1;                 %Miami ... 72 hours 30 g + 50b
% unblindedPixData.repl3.cond30g50b_72h.rpt2 = blindedPixData.repl3.Miami.Miami2;
% unblindedPixData.repl3.cond30g50b_72h.rpt3 = blindedPixData.repl3.Miami.Miami3;
%
% unblindedPixData.repl3.cond30g0b_24h.rpt1 = blindedPixData.repl3.Richmond.Richmond1;            %Richmond ... 24 hours 30g + 0b
% unblindedPixData.repl3.cond30g0b_24h.rpt2 = blindedPixData.repl3.Richmond.Richmond2;
% unblindedPixData.repl3.cond30g0b_24h.rpt3 = blindedPixData.repl3.Richmond.Richmond3;
%
% unblindedPixData.repl3.cond30g0b_72h.rpt1 = blindedPixData.repl3.SanDiego.SanDiego1;            %Gray ... 72 hours 30g +0b
% unblindedPixData.repl3.cond30g0b_72h.rpt2 = blindedPixData.repl3.SanDiego.SanDiego2;
% unblindedPixData.repl3.cond30g0b_72h.rpt3 = blindedPixData.repl3.SanDiego.SanDiego3;
%
% unblindedPixData.repl3.cond0g0b_72h.rpt1 = blindedPixData.repl3.Chicago.Chicago1;               %Chicago ... 72 hours 0g +0b
% unblindedPixData.repl3.cond0g0b_72h.rpt2 = blindedPixData.repl3.Chicago.Chicago2;
% unblindedPixData.repl3.cond0g0b_72h.rpt3 = blindedPixData.repl3.Chicago.Chicago3;
%
% unblindedPixData.repl3.cond0g0b_24h.rpt1 = blindedPixData.repl3.NYC.NYC1;                       %NYC ... 24h 0g +0b
% unblindedPixData.repl3.cond0g0b_24h.rpt2 = blindedPixData.repl3.NYC.NYC2;
% unblindedPixData.repl3.cond0g0b_24h.rpt3 = blindedPixData.repl3.NYC.NYC3;
%
% unblindedPixData.repl3.cond0g50b_72h.rpt1 = blindedPixData.repl3.Baltimore.Baltimore1;          %Baltimore ... 72 hours 0g +50b
% unblindedPixData.repl3.cond0g50b_72h.rpt2 = blindedPixData.repl3.Baltimore.Baltimore2;
% unblindedPixData.repl3.cond0g50b_72h.rpt3 = blindedPixData.repl3.Baltimore.Baltimore3;
%
% unblindedPixData.repl3.cond0g0b_0h.rpt1 = blindedPixData.repl3.Boston.Boston1;                  %Boston ... 0h 0g + nob
% unblindedPixData.repl3.cond0g0b_0h.rpt2 = blindedPixData.repl3.Boston.Boston2;
% unblindedPixData.repl3.cond0g0b_0h.rpt3 = blindedPixData.repl3.Boston.Boston3;
%
% unblindedPixData.repl3.cond30g0b_0h.rpt1 = blindedPixData.repl3.DC.DC1;                         %DC ... 0h 30g + no b
% unblindedPixData.repl3.cond30g0b_0h.rpt2 = blindedPixData.repl3.DC.DC2;
% unblindedPixData.repl3.cond30g0b_0h.rpt3 = blindedPixData.repl3.DC.DC3;
%
% unblindedPixData.repl3.pre.rpt1 = blindedPixData.repl3.LA.LA1;                                  %LA ... pre - injury
% unblindedPixData.repl3.pre.rpt2 = blindedPixData.repl3.LA.LA2;
% unblindedPixData.repl3.pre.rpt3 = blindedPixData.repl3.LA.LA3;
%
%
% %% BRANCHPOINTS -- replicate 1
%
% unblindedBranchData.repl1.cond30g50b_24h.rpt1 = blindedBranchData.repl1.Aquamarine.Aquamarine1;      %Aquamarine ... 24 hours 30g + 50b
% unblindedBranchData.repl1.cond30g50b_24h.rpt2 = blindedBranchData.repl1.Aquamarine.Aquamarine2;
% unblindedBranchData.repl1.cond30g50b_24h.rpt3 = blindedBranchData.repl1.Aquamarine.Aquamarine3;
%
% unblindedBranchData.repl1.cond0g50b_24h.rpt1 = blindedBranchData.repl1.Black.Black1;                  %Black ... 24 hours 0g + 50b
% unblindedBranchData.repl1.cond0g50b_24h.rpt2 = blindedBranchData.repl1.Black.Black2;
% unblindedBranchData.repl1.cond0g50b_24h.rpt3 = blindedBranchData.repl1.Black.Black3;
%
% unblindedBranchData.repl1.cond30g50b_72h.rpt1 = blindedBranchData.repl1.Blue.Blue1;                   %Blue ... 72 hours 30 g + 50b
% unblindedBranchData.repl1.cond30g50b_72h.rpt2 = blindedBranchData.repl1.Blue.Blue2;
% unblindedBranchData.repl1.cond30g50b_72h.rpt3 = blindedBranchData.repl1.Blue.Blue3;
%
% unblindedBranchData.repl1.cond30g0b_24h.rpt1 = blindedBranchData.repl1.Green.Green1;                  %Green ... 24 hours 30g + 0b
% unblindedBranchData.repl1.cond30g0b_24h.rpt2 = blindedBranchData.repl1.Green.Green2;
% unblindedBranchData.repl1.cond30g0b_24h.rpt3 = blindedBranchData.repl1.Green.Green3;
%
% unblindedBranchData.repl1.cond30g0b_72h.rpt1 = blindedBranchData.repl1.Grey.Grey1;                    %Gray ... 72 hours 30g +0b
% unblindedBranchData.repl1.cond30g0b_72h.rpt2 = blindedBranchData.repl1.Grey.Grey2;
% unblindedBranchData.repl1.cond30g0b_72h.rpt3 = blindedBranchData.repl1.Grey.Grey3;
%
% unblindedBranchData.repl1.cond0g0b_72h.rpt1 = blindedBranchData.repl1.Maroon.Maroon1;                 %Maroon ... 72 hours 0g +0b
% unblindedBranchData.repl1.cond0g0b_72h.rpt2 = blindedBranchData.repl1.Maroon.Maroon2;
% unblindedBranchData.repl1.cond0g0b_72h.rpt3 = blindedBranchData.repl1.Maroon.Maroon3;
%
% unblindedBranchData.repl1.cond0g0b_24h.rpt1 = blindedBranchData.repl1.Orange.Orange1;                 %Orange ... 24h 0g +0b
% unblindedBranchData.repl1.cond0g0b_24h.rpt2 = blindedBranchData.repl1.Orange.Orange2;
% unblindedBranchData.repl1.cond0g0b_24h.rpt3 = blindedBranchData.repl1.Orange.Orange3;
%
% unblindedBranchData.repl1.cond0g50b_72h.rpt1 = blindedBranchData.repl1.Purple.Purple1;                %Purple ... 72 hours 0g +50b
% unblindedBranchData.repl1.cond0g50b_72h.rpt2 = blindedBranchData.repl1.Purple.Purple2;
% unblindedBranchData.repl1.cond0g50b_72h.rpt3 = blindedBranchData.repl1.Purple.Purple3;
%
% unblindedBranchData.repl1.cond0g0b_0h.rpt1 = blindedBranchData.repl1.Teal.Teal1;                      %Teal ... 0h 0g + nob
% unblindedBranchData.repl1.cond0g0b_0h.rpt2 = blindedBranchData.repl1.Teal.Teal2;
% unblindedBranchData.repl1.cond0g0b_0h.rpt3 = blindedBranchData.repl1.Teal.Teal3;
%
% unblindedBranchData.repl1.cond30g0b_0h.rpt1 = blindedBranchData.repl1.Violet.Violet1;                 %Violet ... 0h 30g + no b
% unblindedBranchData.repl1.cond30g0b_0h.rpt2 = blindedBranchData.repl1.Violet.Violet2;
% unblindedBranchData.repl1.cond30g0b_0h.rpt3 = blindedBranchData.repl1.Violet.Violet3;
%
% unblindedBranchData.repl1.pre.rpt1 = blindedBranchData.repl1.White.White1;                            %White ... pre - injury
% unblindedBranchData.repl1.pre.rpt2 = blindedBranchData.repl1.White.White2;
% unblindedBranchData.repl1.pre.rpt3 = blindedBranchData.repl1.White.White3;
%
%
% %% BRANCHPOINTS -- replicate 2
%
% unblindedBranchData.repl2.cond30g50b_24h.rpt1 = blindedBranchData.repl2.Ukraine.Ukraine1;     %Ukraine ... 24 hours 30g + 50b
% unblindedBranchData.repl2.cond30g50b_24h.rpt2 = blindedBranchData.repl2.Ukraine.Ukraine2;
% unblindedBranchData.repl2.cond30g50b_24h.rpt3 = blindedBranchData.repl2.Ukraine.Ukraine3;
%
% unblindedBranchData.repl2.cond0g50b_24h.rpt1 = blindedBranchData.repl2.India.India1;          %India ... 24 hours 0g + 50b
% unblindedBranchData.repl2.cond0g50b_24h.rpt2 = blindedBranchData.repl2.India.India2;
% unblindedBranchData.repl2.cond0g50b_24h.rpt3 = blindedBranchData.repl2.India.India3;
%
% unblindedBranchData.repl2.cond30g50b_72h.rpt1 = blindedBranchData.repl2.Croatia.Croatia1;     %Croatia ... 72 hours 30 g + 50b
% unblindedBranchData.repl2.cond30g50b_72h.rpt2 = blindedBranchData.repl2.Croatia.Croatia2;
% unblindedBranchData.repl2.cond30g50b_72h.rpt3 = blindedBranchData.repl2.Croatia.Croatia3;
%
% unblindedBranchData.repl2.cond30g0b_24h.rpt1 = blindedBranchData.repl2.Italy.Italy1;          %Italy ... 24 hours 30g + 0b
% unblindedBranchData.repl2.cond30g0b_24h.rpt2 = blindedBranchData.repl2.Italy.Italy2;
% unblindedBranchData.repl2.cond30g0b_24h.rpt3 = blindedBranchData.repl2.Italy.Italy3;
%
% unblindedBranchData.repl2.cond30g0b_72h.rpt1 = blindedBranchData.repl2.Germany.Germany1;      %Germany ... 72 hours 30g +0b
% unblindedBranchData.repl2.cond30g0b_72h.rpt2 = blindedBranchData.repl2.Germany.Germany2;
% unblindedBranchData.repl2.cond30g0b_72h.rpt3 = blindedBranchData.repl2.Germany.Germany3;
%
% unblindedBranchData.repl2.cond0g0b_72h.rpt1 = blindedBranchData.repl2.France.France1;         %France ... 72 hours 0g +0b
% unblindedBranchData.repl2.cond0g0b_72h.rpt2 = blindedBranchData.repl2.France.France2;
% unblindedBranchData.repl2.cond0g0b_72h.rpt3 = blindedBranchData.repl2.France.France3;
%
% unblindedBranchData.repl2.cond0g0b_24h.rpt1 = blindedBranchData.repl2.Mexico.Mexico1;         %Mexico ... 24h 0g +0b
% unblindedBranchData.repl2.cond0g0b_24h.rpt2 = blindedBranchData.repl2.Mexico.Mexico2;
% unblindedBranchData.repl2.cond0g0b_24h.rpt3 = blindedBranchData.repl2.Mexico.Mexico3;
%
% unblindedBranchData.repl2.cond0g50b_72h.rpt1 = blindedBranchData.repl2.Spain.Spain1;          %Spain ... 72 hours 0g +50b
% unblindedBranchData.repl2.cond0g50b_72h.rpt2 = blindedBranchData.repl2.Spain.Spain2;
%
% unblindedBranchData.repl2.cond0g0b_0h.rpt1 = blindedBranchData.repl2.USA.USA1;                %USA ... 0h 0g + nob
% unblindedBranchData.repl2.cond0g0b_0h.rpt2 = blindedBranchData.repl2.USA.USA2;
% unblindedBranchData.repl2.cond0g0b_0h.rpt3 = blindedBranchData.repl2.USA.USA3;
%
% unblindedBranchData.repl2.cond30g0b_0h.rpt1 = blindedBranchData.repl2.China.China1;           %China ... 0h 30g + no b
% unblindedBranchData.repl2.cond30g0b_0h.rpt2 = blindedBranchData.repl2.China.China2;
% unblindedBranchData.repl2.cond30g0b_0h.rpt3 = blindedBranchData.repl2.China.China3;
%
% unblindedBranchData.repl2.pre.rpt1 = blindedBranchData.repl2.Russia.Russia1;                  %Russia ... pre - injury
% unblindedBranchData.repl2.pre.rpt2 = blindedBranchData.repl2.Russia.Russia2;
% unblindedBranchData.repl2.pre.rpt3 = blindedBranchData.repl2.Russia.Russia3;
% 
%
% %% BRANCHPOINTS -- replicate 3
% 
% unblindedBranchData.repl3.cond30g50b_24h.rpt1 = blindedBranchData.repl3.Phoenix.Phoenix1;             %Phoenix ... 24 hours 30g + 50b
% unblindedBranchData.repl3.cond30g50b_24h.rpt2 = blindedBranchData.repl3.Phoenix.Phoenix2;
% unblindedBranchData.repl3.cond30g50b_24h.rpt3 = blindedBranchData.repl3.Phoenix.Phoenix3;
%
% unblindedBranchData.repl3.cond0g50b_24h.rpt1 = blindedBranchData.repl3.Detroit.Detroit1;              %Detroit ... 24 hours 0g + 50b
% unblindedBranchData.repl3.cond0g50b_24h.rpt2 = blindedBranchData.repl3.Detroit.Detroit2;
% unblindedBranchData.repl3.cond0g50b_24h.rpt3 = blindedBranchData.repl3.Detroit.Detroit3;
%
% unblindedBranchData.repl3.cond30g50b_72h.rpt1 = blindedBranchData.repl3.Miami.Miami1;                 %Miami ... 72 hours 30 g + 50b
% unblindedBranchData.repl3.cond30g50b_72h.rpt2 = blindedBranchData.repl3.Miami.Miami2;
% unblindedBranchData.repl3.cond30g50b_72h.rpt3 = blindedBranchData.repl3.Miami.Miami3;
%
% unblindedBranchData.repl3.cond30g0b_24h.rpt1 = blindedBranchData.repl3.Richmond.Richmond1;            %Richmond ... 24 hours 30g + 0b
% unblindedBranchData.repl3.cond30g0b_24h.rpt2 = blindedBranchData.repl3.Richmond.Richmond2;
% unblindedBranchData.repl3.cond30g0b_24h.rpt3 = blindedBranchData.repl3.Richmond.Richmond3;
%
% unblindedBranchData.repl3.cond30g0b_72h.rpt1 = blindedBranchData.repl3.SanDiego.SanDiego1;            %San Diego ... 72 hours 30g +0b
% unblindedBranchData.repl3.cond30g0b_72h.rpt2 = blindedBranchData.repl3.SanDiego.SanDiego2;
% unblindedBranchData.repl3.cond30g0b_72h.rpt3 = blindedBranchData.repl3.SanDiego.SanDiego3;
%
% unblindedBranchData.repl3.cond0g0b_72h.rpt1 = blindedBranchData.repl3.Chicago.Chicago1;               %Chicago ... 72 hours 0g +0b
% unblindedBranchData.repl3.cond0g0b_72h.rpt2 = blindedBranchData.repl3.Chicago.Chicago2;
% unblindedBranchData.repl3.cond0g0b_72h.rpt3 = blindedBranchData.repl3.Chicago.Chicago3;
%
% unblindedBranchData.repl3.cond0g0b_24h.rpt1 = blindedBranchData.repl3.NYC.NYC1;                       %NYC ... 24h 0g +0b
% unblindedBranchData.repl3.cond0g0b_24h.rpt2 = blindedBranchData.repl3.NYC.NYC2;
% unblindedBranchData.repl3.cond0g0b_24h.rpt3 = blindedBranchData.repl3.NYC.NYC3;
%
% unblindedBranchData.repl3.cond0g50b_72h.rpt1 = blindedBranchData.repl3.Baltimore.Baltimore1;          %Baltimore ... 72 hours 0g +50b
% unblindedBranchData.repl3.cond0g50b_72h.rpt2 = blindedBranchData.repl3.Baltimore.Baltimore2;
% unblindedBranchData.repl3.cond0g50b_72h.rpt3 = blindedBranchData.repl3.Baltimore.Baltimore3;
%
% unblindedBranchData.repl3.cond0g0b_0h.rpt1 = blindedBranchData.repl3.Boston.Boston1;                  %Boston ... 0h 0g + nob
% unblindedBranchData.repl3.cond0g0b_0h.rpt2 = blindedBranchData.repl3.Boston.Boston2;
% unblindedBranchData.repl3.cond0g0b_0h.rpt3 = blindedBranchData.repl3.Boston.Boston3;
%
% unblindedBranchData.repl3.cond30g0b_0h.rpt1 = blindedBranchData.repl3.DC.DC1;                         %DC ... 0h 30g + no b
% unblindedBranchData.repl3.cond30g0b_0h.rpt2 = blindedBranchData.repl3.DC.DC2;
% unblindedBranchData.repl3.cond30g0b_0h.rpt3 = blindedBranchData.repl3.DC.DC3;
%
% unblindedBranchData.repl3.pre.rpt1 = blindedBranchData.repl3.LA.LA1;                                  %LA ... pre - injury
% unblindedBranchData.repl3.pre.rpt2 = blindedBranchData.repl3.LA.LA2;
% unblindedBranchData.repl3.pre.rpt3 = blindedBranchData.repl3.LA.LA3;
%

%%
%Aquamarine ... 24 hours 30g + 50b
%Black ... 24 hours 0g + 50b
%Blue ... 72 hours 30 g + 50b
%Green ... 24 hours 30g + 0b
%Gray ... 72 hours 30g +0b
%Maroon ... 72 hours 0g +0b
%Orange ... 24h 0g +0b
%Purple ... 72 hours 0g +50b
%Teal ... 0h 0g + nob
%Violet ... 0h 30g + no b
%White ... pre - injuryb

%%

% blindFields.repl1 =  fields(blindedPixData.repl1);
% blindFields.repl2 =  fields(blindedPixData.repl2);
% blindFields.repl3 =  fields(blindedPixData.repl3);
%
% unblindFields.repl1 =  fields(unblindedPixData.repl1);
% unblindFields.repl2 =  fields(unblindedPixData.repl2);
% unblindFields.repl3 =  fields(unblindedPixData.repl3);
%
% blindRptNames.repl1 = {'Aquamarine1'; 'Aquamarine2'; ...
%     'Aquamarine3'; 'Black1'; 'Black2'; 'Black3'; 'Blue1'; ...
%     'Blue2'; 'Blue3';  ...
%     'Green1'; 'Green2'; 'Green3'; 'Grey1'; 'Grey2'; 'Grey3'; ...
%     'Maroon1'; 'Maroon2'; 'Maroon3'; 'Orange1'; ...
%     'Orange2'; 'Orange3'; ...
%     'Purple1'; 'Purple2'; 'Purple3'; 'Teal1'; ...
%     'Teal2'; 'Teal3'; 'Violet1'; 'Violet2'; 'Violet3'; 'White1'; ...
%     'White2'; 'White3'};
%
% blindRptNames.repl2 = {'China1'; ...
%     'China2'; 'China3'; 'Croatia1'; 'Croatia2'; 'Croatia3'; 'France1'; ...
%     'France2'; 'France3'; 'Germany1'; 'Germany2'; 'Germany3'; 'India1'; ...
%     'India2'; 'India3'; 'Italy1'; ...
%     'Italy2'; 'Italy3'; 'Mexico1'; 'Mexico2'; 'Mexico3'; 'Russia1'; ...
%     'Russia2'; 'Russia3'; 'Spain1'; 'Spain2';  ...
%     'USA1'; 'USA2'; 'USA3'; 'Ukraine1'; 'Ukraine2'; 'Ukraine3'};
%   
% blindRptNames.repl3 = {'Baltimore1'; 'Baltimore2'; 'Baltimore3'; 'Boston1'; ...
%     'Boston2'; 'Boston3'; 'Chicago1'; 'Chicago2'; 'Chicago3'; 'DC1'; 'DC2'; 'DC3'; ...
%     'Detroit1'; 'Detroit2'; 'Detroit3'; 'LA1'; ...
%     'LA2'; 'LA3'; 'Miami1'; 'Miami2'; 'Miami3'; ...
%     'NYC1'; 'NYC2'; 'NYC3'; ...
%     'Phoenix1'; 'Phoenix2'; 'Phoenix3'; 'Richmond1'; 'Richmond2'; 'Richmond3'; ...
%     'SanDiego1'; 'SanDiego2'; 'SanDiego3'};
%
% save([dataLoc,'cellDeathPixelData_blindUnblind.mat'], 'unblindedPixData', ...
%     'blindedPixData', 'unblindedBranchData', 'blindedBranchData', ...
%     'blindRptNames', 'blindFields', 'unblindFields', 'blindedNumCells', ...
%     'unblindedNumCells', '-append');

%%
load([dataLoc,'cellDeathPixelData_blindUnblind.mat'], 'unblindedPixData', ...
    'unblindedBranchData', 'unblindFields', 'unblindedNumCells');

for ii=1:3
    replName = ['repl',num2str(ii)];
    
    %     for jj=1:length(unblindFields.(replName))
    %
    %         oldName = blindFields.(replName){jj};
    %
    %         newName = unblindFields.(replName){jj};
    %
    %         for kk=1:length(blindRptNames.(replName))
    %             checkName = blindRptNames.(replName){kk};
    %
    %             if strcmp(checkName(1:end-1),oldName)
    %                 unblindRptNames.(replName){kk} = strrep(checkName,checkName(1:end-1),newName);
    %             end %if strcmp
    %         end %for kk
    %
    %     end %for jj
    
    %     for jj=1:length(unblindRptNames.(replName))
    %
    %         condRpt = unblindRptNames.(replName){jj};
    %         thisCond = condRpt(1:end-1);
    %         rptNum = condRpt(end);
    %         rptName = ['rpt',rptNum];
    %
    %         thisData = blindedNumCells.(replName)(:,jj);
    %         thisData(isnan(thisData)) = [];
    %
    %         unblindedNumCells.(replName).(thisCond).(rptName) = thisData';
    %
    %         clear thisData
    %     end %for jj
    
    for jj=1:length(unblindFields.(replName))
        thisVar = unblindFields.(replName){jj};
        numRpts = length(fields(unblindedPixData.(replName).(thisVar)));
        
        for kk=1:numRpts
            rptName = ['rpt',num2str(kk)];
            
            thisData = unblindedPixData.(replName).(thisVar).(rptName) ./ unblindedNumCells.(replName).(thisVar).(rptName);
            unblindedNormPixData_wInf.(replName).(thisVar).(rptName) = thisData;
            thisData(thisData==Inf) = 0;
            thisData(isnan(thisData)) = 0;
            unblindedNormPixData.(replName).(thisVar).(rptName) = thisData;
            
            thatData = unblindedBranchData.(replName).(thisVar).(rptName) ./ unblindedNumCells.(replName).(thisVar).(rptName);
            unblindedNormBranchData_wInf.(replName).(thisVar).(rptName) = thatData;
            thatData(thatData==Inf) = 0;
            thatData(isnan(thatData)) = 0;
            unblindedNormBranchData.(replName).(thisVar).(rptName) = thatData;
            
            clear thisData
        end %for kk
        
    end %for jj
    
end %for ii

%% plotting

clc; close all;

% ORDER
theVars = {'pix';'BPs'};
theConds = { 'pre'; '0g0b_0h'; '30g0b_0h'; '0g0b_24h'; ...
    '30g0b_24h'; '0g50b_24h'; '30g50b_24h'; ...
    '0g0b_72h'; '30g0b_72h'; '0g50b_72h'; '30g50b_72h' } ;
xLoc = [1:1:length(theConds)];


% theColors = [0.0244 0.4350 0.8755;
%     0.1986 0.7214 0.6310;
%     0.9856 0.7372 0.2537];

theColors = [0 0 0;
    0 0.7 0;
    0 0.3 1];

fig1 = figure('Position',[215,176,990,427]);
fig2 = figure('Position',[215,176,990,427]);
fig3 = figure('Position',[215,176,990,427]);
fig4 = figure('Position',[215,176,990,427]);
fig5 = figure('Position',[215,176,990,427]);
fig6 = figure('Position',[215,176,990,427]);
fig7 = figure('Position',[215,176,990,427]);
fig8 = figure('Position',[215,176,990,427]);
fig9 = figure('Position',[215,176,990,427]);
fig10 = figure('Position',[215,176,990,427]);
for ii=1:2
    
    for jj=1:3
        replName = ['repl',num2str(jj)];
        
        for kk=1:length(theConds)
            
            if kk>1
                condName = ['cond',theConds{kk}];
            else
                condName = theConds{kk};
            end
            
            if jj==1
                allData1.(theVars{ii}).(condName) = [];
                allData2.(theVars{ii}).(condName) = [];
                allData9.(condName) = [];
            end %if ii
            
            if ii==1
                rptNum = length(fields(unblindedNormPixData.(replName).(condName)));
            elseif ii==2
                rptNum = length(fields(unblindedNormBranchData.(replName).(condName)));
            end %if ii
            
            storeData1.(theVars{ii}) = [];
            storeData2.(theVars{ii}) = [];
            storeData9 = [];
            for mm=1:rptNum
                rptName = ['rpt',num2str(mm)];
                
                if ii==1
                    plotData1.(theVars{ii}) = unblindedNormPixData.(replName).(condName).(rptName);
                    figure(fig1);
                elseif ii==2
                    plotData1.(theVars{ii}) = unblindedNormBranchData.(replName).(condName).(rptName);
                    figure(fig3);
                end %if ii
                xJitt1 = 0.2*(rand(1,length(plotData1.(theVars{ii})))) - 0.05;
                s1 = scatter(xLoc(kk)+xJitt1, plotData1.(theVars{ii}));
                s1.MarkerEdgeColor = theColors(jj,:);
                thePlotData = plotData1.(theVars{ii});
                thePlotData = thePlotData';
                plotData1.(theVars{ii}) = thePlotData;
                hold on;
                
                if ii==1
                    plotData2.(theVars{ii}) = unblindedPixData.(replName).(condName).(rptName);
                    figure(fig2);
                elseif ii==2
                    plotData2.(theVars{ii}) = unblindedBranchData.(replName).(condName).(rptName);
                    figure(fig4);
                end %if ii
                xJitt2 = 0.2*(rand(1,length(plotData2.(theVars{ii})))) - 0.05;
                s2 = scatter(xLoc(kk)+xJitt2, plotData2.(theVars{ii}));
                s2.MarkerEdgeColor = theColors(jj,:);
                thePlotData = plotData2.(theVars{ii});
                thePlotData = thePlotData';
                plotData2.(theVars{ii}) = thePlotData;
                hold on;
                
                if ii==2
                    figure(fig9);
                    plotData9 = unblindedNumCells.(replName).(condName).(rptName);
                    xJitt9 = 0.2*(rand(1,length(plotData9))) - 0.05;
                    s9 = scatter(xLoc(kk)+xJitt9, plotData9);
                    s9.MarkerEdgeColor = theColors(jj,:);
                    hold on;
                end %if ii
                
                storeData1.(theVars{ii}) = [storeData1.(theVars{ii}); plotData1.(theVars{ii})];
                storeData2.(theVars{ii}) = [storeData2.(theVars{ii}); plotData2.(theVars{ii})];
                if ii==2
                    storeData9 = [storeData9; plotData9'];
                end %if ii
                
                clear plotData1 plotData2 plotData9;
            end %for mm
            
            allData1.(theVars{ii}).(condName) = [allData1.(theVars{ii}).(condName); storeData1.(theVars{ii})];
            allData2.(theVars{ii}).(condName) = [allData2.(theVars{ii}).(condName); storeData2.(theVars{ii})];
            allData9.(condName) = [allData9.(condName); storeData9];
            
            replData1.(theVars{ii}).(condName).(replName) = storeData1.(theVars{ii});
            replData2.(theVars{ii}).(condName).(replName) = storeData2.(theVars{ii});
            replData9.(theVars{ii}).(condName).(replName) = storeData9;
            
            meanName1 = [replName,'_mean1'];
            replData1.(theVars{ii}).(condName).(meanName1) = mean(storeData1.(theVars{ii}));
            meanName2 = [replName,'_mean2'];
            replData2.(theVars{ii}).(condName).(meanName2) = mean(storeData2.(theVars{ii}));
            meanName9 = [replName,'_mean3'];
            replData9.(condName).(meanName9) = mean(storeData9);
            
            normData1.(theVars{ii}).(condName).(replName) = mean(storeData1.(theVars{ii}))/replData1.(theVars{ii}).pre.(meanName1);
            normData2.(theVars{ii}).(condName).(replName) = mean(storeData2.(theVars{ii}))/replData2.(theVars{ii}).pre.(meanName2);
            normData9.(condName).(replName) = mean(storeData9)/replData9.pre.(meanName9);
            
            if ii==1
                figure(fig5);
            elseif ii==2
                figure(fig7);
            end %if ii
            s3 = scatter(xLoc(kk), normData1.(theVars{ii}).(condName).(replName));
            s3.MarkerEdgeColor = theColors(jj,:);
            hold on;
            
            if ii==1
                figure(fig6);
            elseif ii==2
                figure(fig8);
            end %if ii
            s4 = scatter(xLoc(kk), normData2.(theVars{ii}).(condName).(replName));
            s4.MarkerEdgeColor = theColors(jj,:);
            hold on;
            
            if ii==2
                figure(fig10);
                s10 = scatter(xLoc(kk), normData9.(condName).(replName));
                s10.MarkerEdgeColor = theColors(jj,:);
                hold on;
            end %if ii
        end %for kk
        
    end %for jj
    
    for jj=1:length(theConds)
        
        if jj>1
            condName = ['cond',theConds{jj}];
        else
            condName = theConds{jj};
        end %if jj
        
        if ii==1
            figure(fig1);
        elseif ii==2
            figure(fig3);
        end %if ii
        plot([xLoc(jj)-0.25, xLoc(jj)+0.25], [mean(allData1.(theVars{ii}).(condName)) mean(allData1.(theVars{ii}).(condName))], 'color', [1 0 0], 'linewidth', 2);
        hold on;
        
        if ii==1
            figure(fig2);
        elseif ii==2
            figure(fig4);
        end %if ii
        plot([xLoc(jj)-0.25, xLoc(jj)+0.25], [mean(allData2.(theVars{ii}).(condName)) mean(allData2.(theVars{ii}).(condName))], 'color', [1 0 0], 'linewidth', 2);
        hold on;
        
        if ii==1
            figure(fig5);
        elseif ii==2
            figure(fig7);
        end %if ii
        data2avg1 = [normData1.(theVars{ii}).(condName).repl1, normData1.(theVars{ii}).(condName).repl2, normData1.(theVars{ii}).(condName).repl3];
        plot([xLoc(jj)-0.25, xLoc(jj)+0.25], [mean(data2avg1) mean(data2avg1)], 'color', [1 0 0], 'linewidth', 2);
        hold on;
        
        if ii==1
            figure(fig6);
        elseif ii==2
            figure(fig8);
        end %if ii
        data2avg2 = [normData2.(theVars{ii}).(condName).repl1, normData2.(theVars{ii}).(condName).repl2, normData2.(theVars{ii}).(condName).repl3];
        plot([xLoc(jj)-0.25, xLoc(jj)+0.25], [mean(data2avg2) mean(data2avg2)], 'color', [1 0 0], 'linewidth', 2);
        hold on;
        
        if ii==2
            figure(fig9);
            plot([xLoc(jj)-0.25, xLoc(jj)+0.25], [mean(allData9.(condName)) mean(allData9.(condName))], 'color', [1 0 0], 'linewidth', 2);
            hold on;
            
            figure(fig10);
            data2avg3 = [normData9.(condName).repl1, normData9.(condName).repl2, normData9.(condName).repl3];
            plot([xLoc(jj)-0.25, xLoc(jj)+0.25], [mean(data2avg3) mean(data2avg3)], 'color', [1 0 0], 'linewidth', 2);
            hold on;
        end %if ii
        
    end %for jj
end %for ii

figure(fig1);
xlim([0 17]);
title('dendritic length normalized by cell count');
saveas(fig1,[dataLoc,'dendritesNormByCells.fig'])

figure(fig2);
xlim([0 17]);
title('dendritic length (not normalized)');
saveas(fig2,[dataLoc,'dendrites.fig'])

figure(fig3);
xlim([0 17]);
title('branchpoints normalized by cell count');
saveas(fig3,[dataLoc,'branchesNormByCells.fig'])

figure(fig4);
xlim([0 17]);
title('branchpoints (not normalized)');
saveas(fig4,[dataLoc,'branches.fig'])

figure(fig5);
xlim([0 17]);
title('dendritic length normalized by cell count & pre-injury levels');
saveas(fig5,[dataLoc,'dendritesNormByCellsAndPre.fig'])

figure(fig6);
xlim([0 17]);
title('dendritic length - normalized by pre-injury levels');
saveas(fig6,[dataLoc,'dendritesNormByPre.fig'])

figure(fig7);
xlim([0 17]);
title('branchpoints normalized by cell count & pre-injury levels');
saveas(fig7,[dataLoc,'branchesNormByCellsAndPre.fig'])

figure(fig8);
xlim([0 17]);
title('branchpoints - normalized by pre-injury levels');
saveas(fig8,[dataLoc,'branchesNormByPre.fig'])

figure(fig9);
xlim([0 17]);
title('cell counts');
saveas(fig9,[dataLoc,'cellCounts.fig'])

figure(fig10);
xlim([0 17]);
title('cell counts - normalized by pre-injury levels');
saveas(fig10,[dataLoc,'cellCountsNormByPre.fig'])

save([dataLoc,'plottingData_unblinded.mat'], 'allData1', 'allData2', ...
    'allData9', 'normData1', 'normData2', 'normData9', 'replData1', ...
    'replData2', 'replData9', 'unblindedNormPixData_wInf', 'unblindedNormPixData', ...
    'unblindedNumCells', 'unblindedNormBranchData_wInf', 'unblindedNormBranchData', ...
    'unblindedPixData', 'unblindedBranchData', 'unblindFields');

%% plot for real & stats -- dendrite and branchpoint data
% WELL AVERAGES (NOT NORMALIZED)

clc; close all;
clearvars -except unblindedPixData unblindedBranchData;

% ORDER
theVars = {'pix';'BPs'};
theConds = { 'pre'; '0g0b_24h'; '0g50b_24h'; '30g0b_24h'; '30g50b_24h'; ...
    '0g0b_72h'; '0g50b_72h'; '30g0b_72h'; '30g50b_72h' } ;

xLoc = [1:1:length(theConds)];

% theColors = [0.0244 0.4350 0.8755;
%     0.1986 0.7214 0.6310;
%     0.9856 0.7372 0.2537];

theColors = [1 0 0;
    0 1 0;
    0 0 1];

% WELL AVERAGES
for ii=1:2
    
    if ii==1
        thisData = unblindedPixData;
    elseif ii==2
        thisData = unblindedBranchData;
    end %if ii
    
    for jj=1:length(fields(thisData)) %num repeats, all have 3
        
        replName = ['repl',num2str(jj)];
        dsxnName = ['dsxn',num2str(jj)];
        for kk=1:length(theConds)
            
            if strcmp(theConds{kk},'pre')
                condName = theConds{kk};
            else
                condName = ['cond',theConds{kk}];
            end %if strcmp
            
            theseFields = fields(thisData.(replName).(condName));
            for mm=1:length(theseFields)
                rptName = ['rpt',num2str(mm)];
                wellName = ['well',num2str(mm)];
                wellMean = ['well',num2str(mm),'_mean'];
                
                if ii==1
                    plottingPixData.(dsxnName).(condName).(wellName) = thisData.(replName).(condName).(rptName);
                    plottingPixData.(dsxnName).(condName).(wellMean) = mean(plottingPixData.(dsxnName).(condName).(wellName));
                elseif ii==2
                    plottingBranchData.(dsxnName).(condName).(wellName) = thisData.(replName).(condName).(rptName);
                    plottingBranchData.(dsxnName).(condName).(wellMean) = mean(plottingBranchData.(dsxnName).(condName).(wellName));
                end %if ii
                
            end %for mm
            
        end %for kk
        
    end %for jj
    
end %for ii
clear thisData

% now do stats for only well averages
thisCondMatrix = cell(116,1);
thisDsxnMatrix = cell(116,1);
thisWellMatrix = cell(116,1);
for ii=1:2
    
    if ii==1
        thisData = plottingPixData;
    elseif ii==2
        thisData = plottingBranchData;
    end %if ii
    
    dataVector = [];
    count = 0;
    for jj=1:length(fields(thisData))
        dsxnName = ['dsxn',num2str(jj)];
        
        for kk=1:length(theConds)
            
            if strcmp(theConds{kk},'pre')
                condName = theConds{kk};
            else
                condName = ['cond',theConds{kk}];
            end %if strcmp
            
            theseFields = fields(thisData.(dsxnName).(condName));
            
            for mm=1:length(theseFields)/2
                
                wellName = ['well',num2str(mm)];
                wellMean = ['well',num2str(mm),'_mean'];
                
                data2cat = thisData.(dsxnName).(condName).(wellMean); %%%
                
                dataVector = [dataVector; data2cat];
                count = count + 1;
                
                thisCondMatrix{count,1} = condName;
                thisDsxnMatrix{count,1} = dsxnName;
                thisWellMatrix{count,1} = wellName;
            end %for mm
            
        end %for kk
        
    end %for jj
    
    if ii==1
        pixDataVector = dataVector;
        pixCondVector = thisCondMatrix;
        pixDsxnVector = thisDsxnMatrix;
        pixWellVector = thisWellMatrix;
    elseif ii==2
        branchDataVector = dataVector;
        branchCondVector = thisCondMatrix;
        branchDsxnVector = thisDsxnMatrix;
        branchWellVector = thisWellMatrix;
    end %if ii
    
end %for ii
clear thisData theseData dataVector;

% n-way anova to get interaction
for ii=1:2
    
    if ii==1
        thisDataVector = pixDataVector;
        thisCondVector = pixCondVector;
        thisDsxnVector = pixDsxnVector;
        thisWellVector = pixWellVector;
    elseif ii==2
        thisDataVector = branchDataVector;
        thisCondVector = branchCondVector;
        thisDsxnVector = branchDsxnVector;
        thisWellVector = branchWellVector;
    end %if ii
    
    [p.(theVars{ii}), tbl.(theVars{ii}), stats.(theVars{ii})] = ...
        anova1(thisDataVector,thisCondVector,'off');
    %     [p.(theVars{ii}), tbl.(theVars{ii}), stats.(theVars{ii})] = ...
    %         anovan(thisDataVector,{thisCondVector},'model','interaction','varnames',{'treatment'});
    
    % tukey's multiple comparisons
    [c.(theVars{ii}), m.(theVars{ii}), h.(theVars{ii}), gnames.(theVars{ii})] = ...
        multcompare(stats.(theVars{ii}),'Display','off');
    
    disp('')
    disp(theVars{ii});
    thisC = c.(theVars{ii});
    for jj=1:size(thisC,1)
        thisP = thisC(jj,6);
        if thisP<0.10
            col1 = gnames.(theVars{ii}){thisC(jj,1)};
            col2 = gnames.(theVars{ii}){thisC(jj,2)};
            disp('')
            dispThis = [col1, ' & ', col2, ', p=', num2str(thisP)];
            disp(dispThis);
        end %if thisP
    end %for jj
end %for ii
% RESULTS
% pix
% pre & cond0g0b_24h, p=3.3509e-05
% pre & cond0g50b_24h, p=0.0020798
% pre & cond30g0b_24h, p=7.2888e-11
% pre & cond30g50b_24h, p=4.7178e-10
% pre & cond0g0b_72h, p=2.8586e-09
% pre & cond0g50b_72h, p=1.366e-06
% pre & cond30g0b_72h, p=3.085e-11
% pre & cond30g50b_72h, p=2.7684e-10
% cond0g50b_24h & cond30g0b_24h, p=0.016318
% cond0g50b_24h & cond30g50b_24h, p=0.04963
% BPs
% pre & cond0g0b_24h, p=7.4888e-06
% pre & cond0g50b_24h, p=0.0011802
% pre & cond30g0b_24h, p=4.3599e-09
% pre & cond30g50b_24h, p=3.1975e-08
% pre & cond0g0b_72h, p=1.4707e-08
% pre & cond0g50b_72h, p=1.3739e-06
% pre & cond30g0b_72h, p=1.2235e-08
% pre & cond30g50b_72h, p=3.1239e-08


% NOW PLOT
fig1 = figure('Position',[215,176,990,427]);
fig2 = figure('Position',[215,176,990,427]);
for ii=1:2
    
    for jj=1:3
        dsxnName = ['dsxn',num2str(jj)];
        
        for kk=1:length(theConds)
            
            if strcmp(theConds{kk},'pre')
                
                condName = theConds{kk};
            else
                
                condName = ['cond',theConds{kk}];
            end %if kk
            if jj==1
                data2plot.(theVars{ii}).(condName) = [];
            end %if ii
            
            if ii==1
                numWells = length(fields(plottingPixData.(dsxnName).(condName)))/2;
            elseif ii==2
                numWells = length(fields(plottingBranchData.(dsxnName).(condName)))/2;
            end %if ii
            
            for mm=1:numWells
                wellMean = ['well',num2str(mm),'_mean'];
                
                if ii==1
                    plotData.(theVars{ii}).(dsxnName).(condName)(mm) = plottingPixData.(dsxnName).(condName).(wellMean);
                    figure(fig1);
                elseif ii==2
                    plotData.(theVars{ii}).(dsxnName).(condName)(mm) = plottingBranchData.(dsxnName).(condName).(wellMean);
                    figure(fig2);
                end %if ii
            end %for mm
            xJitt1 = 0.2*(rand(1,length(plotData.(theVars{ii}).(dsxnName).(condName)))) - 0.05;
            s1 = scatter(xLoc(kk)+xJitt1, plotData.(theVars{ii}).(dsxnName).(condName));
            s1.MarkerEdgeColor = theColors(jj,:);
            hold on;
        end %for kk
    end %for jj
    
    for jj=1:length(theConds)
        
        if jj>1
            condName = ['cond',theConds{jj}];
        else
            condName = theConds{jj};
        end %if jj
        
        if ii==1
            figure(fig1);
        elseif ii==2
            figure(fig2);
        end %if ii
        theData = [plotData.(theVars{ii}).dsxn1.(condName), ...
            plotData.(theVars{ii}).dsxn2.(condName), ...
            plotData.(theVars{ii}).dsxn3.(condName)];
        meanData = mean(theData);
        plot([xLoc(jj)-0.25, xLoc(jj)+0.25], [meanData meanData], 'color', [0 0 0], 'linewidth', 2);
        hold on;
        
    end %for jj
end %for ii

figure(fig1);
xlim([0 14]);
title('dendritic length (not normalized)');
xticks([1:13]);
xtickangle(45);
xticklabels({'pre', '0g 0B', '0g 50B', '30g 0B', '30g 50B', ...
    0g 0B', '0g 50B', '30g 0B', '30g 50B' });
% saveas(fig1,[dataLoc,'dendritesNormByCells.fig']);

figure(fig2);
xlim([0 14]);
title('branchpoints (not normalized)');
xticks([1:13]);
xtickangle(45);
xticklabels({'pre', '0g 0B', '0g 50B', '30g 0B', '30g 50B', ...
    0g 0B', '0g 50B', '30g 0B', '30g 50B' });
% saveas(fig2,[dataLoc,'dendrites.fig']);

% % now do stats for ALL points


%% plot for real & stats -- dendrite and branchpoint data
% REPLICATE AVERAGES (NOT NORMALIZED)

clc; clear all; close all;

dataLoc = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\MEA papers -- addl experiments\EXP for BDNF + glu\Glutamate cell death, BDNF treatment\v3 (final) of analysis\';
theVars = {'pix';'BPs'};
theConds = { 'pre'; '0g0b_24h'; '0g50b_24h'; '30g0b_24h'; '30g50b_24h'; ...
    '0g0b_72h'; '0g50b_72h'; '30g0b_72h'; '30g50b_72h' } ;

load([dataLoc,'plottingData_unblinded.mat'], 'unblindedNormPixData', ...
    'unblindedNumCells', 'unblindedNormBranchData', ...
    'unblindedPixData', 'unblindedBranchData', 'unblindFields');


% *** not normalized data *** %

% get dissection (REPLICATE) averages ready
for ii=1:2
    
    if ii==1
        thisData = unblindedPixData;
    elseif ii==2
        thisData = unblindedBranchData;
    end %if ii
    
    for jj=1:length(fields(thisData)) %num repeats, all have 3
        
        replName = ['repl',num2str(jj)];
        dsxnName = ['dsxn',num2str(jj)];
        for kk=1:length(theConds)
            
            if strcmp(theConds{kk},'pre')
                condName = theConds{kk};
            else
                condName = ['cond',theConds{kk}];
            end %if strcmp
            
            theseFields = fields(thisData.(replName).(condName));
            data2avg = [];
            for mm=1:length(theseFields)
                rptName = ['rpt',num2str(mm)];
                
                data2avg = [data2avg, thisData.(replName).(condName).(rptName)];
            end %for mm
            if ii==1
                plottingPixData.(dsxnName).(condName).mean = mean(data2avg);
            elseif ii==2
                plottingBranchData.(dsxnName).(condName).mean = mean(data2avg);
            end %if ii
            
        end %for kk
        
    end %for jj
    
end %for ii
clear thisData

% now do stats for only REPLICATE averages
thisCondMatrix = cell(3,13);
thisDsxnMatrix = cell(3,1);
for ii=1:2
    
    if ii==1
        thisData = plottingPixData;
    elseif ii==2
        thisData = plottingBranchData;
    end %if ii
    
    dataVector = [];
    count = 0;
    for jj=1:length(fields(thisData))
        dsxnName = ['dsxn',num2str(jj)];
        
        data2cat = [];
        for kk=1:length(theConds)
            
            if strcmp(theConds{kk},'pre')
                condName = theConds{kk};
            else
                condName = ['cond',theConds{kk}];
            end %if strcmp
            
            data2cat = [data2cat, thisData.(dsxnName).(condName).mean];
            
            thisCondMatrix{jj,kk} = condName;
            if kk==1
                thisDsxnMatrix{jj,kk} = dsxnName;
            end %if kk
        end %for kk
        dataVector = [dataVector; data2cat];
        
    end %for jj
    
    if ii==1
        pixDataVector = dataVector;
        pixCondVector = thisCondMatrix;
        pixDsxnVector = thisDsxnMatrix;
    elseif ii==2
        branchDataVector = dataVector;
        branchCondVector = thisCondMatrix;
        branchDsxnVector = thisDsxnMatrix;
    end %if ii
    
end %for ii
clear thisData theseData dataVector;

% RM ANOVA TO GET INTERACTIONS
for ii=1:2
    
    if ii==1
        thisDataVector = pixDataVector;
        thisCondVector = pixCondVector;
        thisDsxnVector = pixDsxnVector;
    elseif ii==2
        thisDataVector = branchDataVector;
        thisCondVector = branchCondVector;
        thisDsxnVector = branchDsxnVector;
    end %if ii
    
    myTable = table(thisDataVector(:,1), thisDataVector(:,2), thisDataVector(:,3), thisDataVector(:,4),...
        thisDataVector(:,5), thisDataVector(:,6), thisDataVector(:,7), thisDataVector(:,8),...
        thisDataVector(:,9), thisDataVector(:,10), thisDataVector(:,11), thisDataVector(:,12),...
        thisDataVector(:,13), 'VariableNames', ...
        {'pre','cond0g0b_24h','cond0g50b_24h','cond30g0b_24h','cond30g50b_24h',...
        'cond0g0b_72h','cond0g50b_72h','cond30g0b_72h',...
        'cond30g50b_72h'});
    
    Time = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13];
    myTime = array2table(categorical(Time),'VariableNames',{'treatment'});
    
    rm.(theVars{ii}) = fitrm(myTable, 'pre-cond30g50b_72h~1', 'WithinDesign', myTime);
    
    [tbl.(theVars{ii}), btwnSubj.(theVars{ii}), wthnSubj.(theVars{ii}), hypVal.(theVars{ii})] ...
        = ranova(rm.(theVars{ii}), 'WithinModel', 'treatment');
    
    [cTreat.(theVars{ii})] = multcompare(rm.(theVars{ii}),'treatment');
    
    disp('')
    disp(theVars{ii});
    thisC = cTreat.(theVars{ii});
    for jj=1:size(thisC,1)
        thisP = table2array(thisC(jj,5));
        if thisP<0.10
            idx1 = cellstr(table2array(thisC(jj,1)));
            col1 = theConds{str2double(idx1{1,1})+1};
            idx2 = cellstr(table2array(thisC(jj,2)));
            col2 = theConds{str2double(idx2{1,1})+1};
            disp('')
            dispThis = [col1, ' & ', col2, ', p=', num2str(thisP)];
            disp(dispThis);
        end %if thisP
    end %for jj
    
end %for ii

% RESULTS
% pix
% 0g0b_72h & 0g50b_72h, p=0.067781
% 0g0b_72h & 30g0b_72h, p=0.02722 ***
% 0g50b_72h & 0g0b_72h, p=0.067781
% 0g50b_72h & 30g0b_72h, p=0.099535
% BPs

%% plot for real & stats -- dendrite & branchpoint data normalized to pre-injury
% WELL AVERAGES (NORMALIZED)

clc; %close all;
clearvars -except unblindedPixData unblindedBranchData;

% ORDER
theVars = {'pix';'BPs'};
theConds = { 'pre'; '0g0b_24h'; '0g50b_24h'; '30g0b_24h'; '30g50b_24h'; ...
    '0g0b_72h'; '0g50b_72h'; '30g0b_72h'; '30g50b_72h' } ;

xLoc = [1:1:length(theConds)];

% theColors = [0.0244 0.4350 0.8755;
%     0.1986 0.7214 0.6310;
%     0.9856 0.7372 0.2537];

theColors = [1 0 0;
    0 1 0;
    0 0 1];

for ii=1:2
    
    if ii==1
        thisData = unblindedPixData;
    elseif ii==2
        thisData = unblindedBranchData;
    end %if ii
    
    for jj=1:length(fields(thisData)) %num repeats, all have 3
        
        replName = ['repl',num2str(jj)];
        dsxnName = ['dsxn',num2str(jj)];
        for kk=1:length(theConds)
            
            if strcmp(theConds{kk},'pre')
                condName = theConds{kk};
                meanData = [];
                for ZZ=1:length(fields(thisData.(replName).(condName)))
                    rptName = ['rpt',num2str(ZZ)];
                    meanData = [meanData, thisData.(replName).(condName).(rptName)];
                end %for ZZ
                mean2norm = mean(meanData);
                
                % don't include this data because messes up stats
            else
                condName = ['cond',theConds{kk}];
                
                theseFields = fields(thisData.(replName).(condName));
                for mm=1:length(theseFields)
                    rptName = ['rpt',num2str(mm)];
                    wellName = ['well',num2str(mm)];
                    wellMean = ['well',num2str(mm),'_mean'];
                    
                    wellData2mean = thisData.(replName).(condName).(rptName);
                    if ii==1
                        plottingPixData.(dsxnName).(condName).(wellName) = wellData2mean/mean2norm;
                        plottingPixData.(dsxnName).(condName).(wellMean) = mean(wellData2mean)/mean2norm;
                    elseif ii==2
                        plottingBranchData.(dsxnName).(condName).(wellName) = wellData2mean/mean2norm;
                        plottingBranchData.(dsxnName).(condName).(wellMean) = mean(wellData2mean)/mean2norm;
                    end %if ii
                    
                end %for mm
            end %if strcmp
            
        end %for kk
        
    end %for jj
    
end %for ii
clear thisData

% now do stats for only well averages
thisCondMatrix = cell(107,1);
thisDsxnMatrix = cell(107,1);
thisWellMatrix = cell(107,1);
for ii=1:2
    
    if ii==1
        thisData = plottingPixData;
    elseif ii==2
        thisData = plottingBranchData;
    end %if ii
    
    dataVector = [];
    count = 0;
    for jj=1:length(fields(thisData))
        dsxnName = ['dsxn',num2str(jj)];
        
        for kk=1:length(theConds)
            
            if strcmp(theConds{kk},'pre')
                condName = theConds{kk};
            else
                condName = ['cond',theConds{kk}];
                
                theseFields = fields(thisData.(dsxnName).(condName));
                
                for mm=1:length(theseFields)/2
                    
                    wellName = ['well',num2str(mm)];
                    wellMean = ['well',num2str(mm),'_mean'];
                    
                    data2cat = thisData.(dsxnName).(condName).(wellMean); %%%
                    
                    dataVector = [dataVector; data2cat];
                    count = count + 1;
                    
                    thisCondMatrix{count,1} = condName;
                    thisDsxnMatrix{count,1} = dsxnName;
                    thisWellMatrix{count,1} = wellName;
                end %for mm
            end %if strcmp
        end %for kk
        
    end %for jj
    
    if ii==1
        pixDataVector = dataVector;
        pixCondVector = thisCondMatrix;
        pixDsxnVector = thisDsxnMatrix;
        pixWellVector = thisWellMatrix;
    elseif ii==2
        branchDataVector = dataVector;
        branchCondVector = thisCondMatrix;
        branchDsxnVector = thisDsxnMatrix;
        branchWellVector = thisWellMatrix;
    end %if ii
    
end %for ii
clear thisData theseData dataVector;

% n-way anova to get interaction
for ii=1:2
    
    if ii==1
        thisDataVector = pixDataVector;
        thisCondVector = pixCondVector;
        thisDsxnVector = pixDsxnVector;
        thisWellVector = pixWellVector;
    elseif ii==2
        thisDataVector = branchDataVector;
        thisCondVector = branchCondVector;
        thisDsxnVector = branchDsxnVector;
        thisWellVector = branchWellVector;
    end %if ii
    
    [p.(theVars{ii}), tbl.(theVars{ii}), stats.(theVars{ii})] = ...
        anova1(thisDataVector,thisCondVector,'off');
    %     [p.(theVars{ii}), tbl.(theVars{ii}), stats.(theVars{ii})] = ...
    %         anovan(thisDataVector,{thisCondVector},'model','interaction','varnames',{'treatment'});
    
    % tukey's multiple comparisons
    [c.(theVars{ii}), m.(theVars{ii}), h.(theVars{ii}), gnames.(theVars{ii})] = ...
        multcompare(stats.(theVars{ii}),'Display','off');
    
    disp('')
    disp(theVars{ii});
    thisC = c.(theVars{ii});
    for jj=1:size(thisC,1)
        thisP = thisC(jj,6);
        if thisP<0.10
            col1 = gnames.(theVars{ii}){thisC(jj,1)};
            col2 = gnames.(theVars{ii}){thisC(jj,2)};
            disp('')
            dispThis = [col1, ' & ', col2, ', p=', num2str(thisP)];
            disp(dispThis);
        end %if thisP
    end %for jj
end %for ii
% RESULTS
% pix
% cond0g0b_24h & cond30g0b_24h, p=0.08637
% cond0g50b_24h & cond30g0b_24h, p=0.0073446
% cond0g50b_24h & cond30g50b_24h, p=0.030442
% BPs
% cond0g50b_24h & cond30g0b_24h, p=0.089255

% NOW PLOT
fig3 = figure('Position',[215,176,990,427]);
fig4 = figure('Position',[215,176,990,427]);
for ii=1:2
    
    for jj=1:3
        dsxnName = ['dsxn',num2str(jj)];
        
        for kk=1:length(theConds)
            
            if strcmp('pre',theConds{kk})
                condName = theConds{kk};
            else
                
                condName = ['cond',theConds{kk}];
                
                if jj==1
                    data2plot.(theVars{ii}).(condName) = [];
                end %if ii
                
                if ii==1
                    numWells = length(fields(plottingPixData.(dsxnName).(condName)))/2;
                elseif ii==2
                    numWells = length(fields(plottingBranchData.(dsxnName).(condName)))/2;
                end %if ii
                
                for mm=1:numWells
                    wellMean = ['well',num2str(mm),'_mean'];
                    
                    if ii==1
                        plotData.(theVars{ii}).(dsxnName).(condName)(mm) = plottingPixData.(dsxnName).(condName).(wellMean);
                        figure(fig3);
                    elseif ii==2
                        plotData.(theVars{ii}).(dsxnName).(condName)(mm) = plottingBranchData.(dsxnName).(condName).(wellMean);
                        figure(fig4);
                    end %if ii
                end %for mm
                xJitt1 = 0.2*(rand(1,length(plotData.(theVars{ii}).(dsxnName).(condName)))) - 0.05;
                s1 = scatter(xLoc(kk)+xJitt1-1, plotData.(theVars{ii}).(dsxnName).(condName));
                s1.MarkerEdgeColor = theColors(jj,:);
                hold on;
                
            end %if kk
            
        end %for kk
        
    end %for jj
    
    for jj=1:length(theConds)
        
        if strcmp('pre',theConds{jj})
            condName = theConds{jj};
            
        else
            condName = ['cond',theConds{jj}];
            
            if ii==1
                figure(fig3);
            elseif ii==2
                figure(fig4);
            end %if ii
            theData = [plotData.(theVars{ii}).dsxn1.(condName), ...
                plotData.(theVars{ii}).dsxn2.(condName), ...
                plotData.(theVars{ii}).dsxn3.(condName)];
            meanData = mean(theData);
            plot([xLoc(jj)-1.25, xLoc(jj)-0.75], [meanData meanData], 'color', [0 0 0], 'linewidth', 2);
            hold on;
            
        end %if jj
        
    end %for jj
end %for ii

figure(fig3);
xlim([0 13]);
title('dendritic length normalized to pre-injury levels');
% saveas(fig1,[dataLoc,'dendritesNormByCells.fig']);
xticks([1:12]);
xtickangle(45);
xticklabels({'0g 0B', '0g 50B', '30g 0B', '30g 50B', ...
    0g 0B', '0g 50B', '30g 0B', '30g 50B' });

figure(fig4);
xlim([0 13]);
title('branchpoints normalized to pre-injury levels');
% saveas(fig2,[dataLoc,'dendrites.fig']);
xticks([1:12]);
xtickangle(45);
xticklabels({'0g 0B', '0g 50B', '30g 0B', '30g 50B', ...
    0g 0B', '0g 50B', '30g 0B', '30g 50B' });

% % now do stats for ALL points

%% plot for real & stats -- dendrite & branchpoint data normalized to pre-injury
% REPLICATE AVERAGES (NORMALIZED)

clc; clear all; close all;

dataLoc = 'C:\Users\kmfo8\Dropbox\Rutgers\Firestein Lab\MEA papers -- addl experiments\EXP for BDNF + glu\Glutamate cell death, BDNF treatment\v3 (final) of analysis\';
theVars = {'pix';'BPs'};
theConds = { 'pre'; '0g0b_24h'; '0g50b_24h'; '30g0b_24h'; '30g50b_24h'; ...
    '0g0b_72h'; '0g50b_72h'; '30g0b_72h'; '30g50b_72h' } ;

load([dataLoc,'plottingData_unblinded.mat'], 'unblindedNormPixData', ...
    'unblindedNumCells', 'unblindedNormBranchData', ...
    'unblindedPixData', 'unblindedBranchData', 'unblindFields');


% *** NORMALIZED data *** %

% get dissection (REPLICATE) averages ready
for ii=1:2
    
    if ii==1
        thisData = unblindedPixData;%unblindedNormPixData;
    elseif ii==2
        thisData = unblindedBranchData;%unblindedNormBranchData;
    end %if ii
    
    for jj=1:length(fields(thisData)) %num repeats, all have 3
        
        replName = ['repl',num2str(jj)];
        dsxnName = ['dsxn',num2str(jj)];
        for kk=1:length(theConds)
            
            if strcmp(theConds{kk},'pre')
                condName = theConds{kk};
                
                theseFields = fields(thisData.(replName).(condName));
                data2norm = [];
                for mm=1:length(theseFields)
                    rptName = ['rpt',num2str(mm)];
                    
                    data2norm = [data2norm, thisData.(replName).(condName).(rptName)];
                end %for mm
            else
                condName = ['cond',theConds{kk}];
                
                theseFields = fields(thisData.(replName).(condName));
                data2avg = [];
                for mm=1:length(theseFields)
                    rptName = ['rpt',num2str(mm)];
                    
                    data2avg = [data2avg, thisData.(replName).(condName).(rptName)];
                end %for mm
                if ii==1
                    plottingPixData.(dsxnName).(condName).mean = mean(data2avg)/mean(data2norm);
                elseif ii==2
                    plottingBranchData.(dsxnName).(condName).mean = mean(data2avg)/mean(data2norm);
                end %if ii
            end %if strcmp
            
        end %for kk
        
    end %for jj
    
end %for ii
clear thisData

% now do stats for only REPLICATE averages
thisCondMatrix = cell(3,12);
thisDsxnMatrix = cell(3,1);
for ii=1:2
    
    if ii==1
        thisData = plottingPixData;
    elseif ii==2
        thisData = plottingBranchData;
    end %if ii
    
    dataVector = [];
    count = 0;
    for jj=1:length(fields(thisData))
        dsxnName = ['dsxn',num2str(jj)];
        
        data2cat = [];
        for kk=2:length(theConds) %***
            
            if strcmp(theConds{kk},'pre')
                condName = theConds{kk};
            else
                condName = ['cond',theConds{kk}];
            end %if strcmp
            
            data2cat = [data2cat, thisData.(dsxnName).(condName).mean];
            
            thisCondMatrix{jj,kk} = condName;
            if kk==1
                thisDsxnMatrix{jj,kk} = dsxnName;
            end %if kk
        end %for kk
        dataVector = [dataVector; data2cat];
        
    end %for jj
    
    if ii==1
        pixDataVector = dataVector;
        pixCondVector = thisCondMatrix;
        pixDsxnVector = thisDsxnMatrix;
    elseif ii==2
        branchDataVector = dataVector;
        branchCondVector = thisCondMatrix;
        branchDsxnVector = thisDsxnMatrix;
    end %if ii
    
end %for ii
clear thisData theseData dataVector;

% RM ANOVA TO GET INTERACTIONS
for ii=1:2
    
    if ii==1
        thisDataVector = pixDataVector;
        thisCondVector = pixCondVector;
        thisDsxnVector = pixDsxnVector;
    elseif ii==2
        thisDataVector = branchDataVector;
        thisCondVector = branchCondVector;
        thisDsxnVector = branchDsxnVector;
    end %if ii
    
    myTable = table(thisDataVector(:,1), thisDataVector(:,2), thisDataVector(:,3), thisDataVector(:,4),...
        thisDataVector(:,5), thisDataVector(:,6), thisDataVector(:,7), thisDataVector(:,8),...
        thisDataVector(:,9), thisDataVector(:,10), thisDataVector(:,11), thisDataVector(:,12),...
        'VariableNames', ...
        {'cond0g0b_24h','cond0g50b_24h','cond30g0b_24h','cond30g50b_24h',...
        'cond0g0b_72h','cond0g50b_72h','cond30g0b_72h', 'cond30g50b_72h'});
    
    Time = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12];
    myTime = array2table(categorical(Time),'VariableNames',{'treatment'});
    
    rm.(theVars{ii}) = fitrm(myTable, 'cond0g0b_24h-cond30g50b_72h~1', 'WithinDesign', myTime);
    
    [tbl.(theVars{ii}), btwnSubj.(theVars{ii}), wthnSubj.(theVars{ii}), hypVal.(theVars{ii})] ...
        = ranova(rm.(theVars{ii}), 'WithinModel', 'treatment');
    
    [cTreat.(theVars{ii})] = multcompare(rm.(theVars{ii}),'treatment');
    
    disp('')
    disp(theVars{ii});
    thisC = cTreat.(theVars{ii});
    for jj=1:size(thisC,1)
        thisP = table2array(thisC(jj,5));
        if thisP<0.10
            idx1 = cellstr(table2array(thisC(jj,1)));
            col1 = theConds{str2double(idx1{1,1})+1};
            idx2 = cellstr(table2array(thisC(jj,2)));
            col2 = theConds{str2double(idx2{1,1})+1};
            disp('')
            dispThis = [col1, ' & ', col2, ', p=', num2str(thisP)];
            disp(dispThis);
        end %if thisP
    end %for jj
    
end %for ii
% RESULTS
% pix
% 0g50b_24h & 30g0b_24h, p=0.076505
% 0g50b_24h & 30g50b_24h, p=0.026895
% BPs
%%
% doing RM anova a different way -- columns are time
clc;

% now do stats for only REPLICATE averages
thisDataMatrix = zeros(18,2);
thisCondMatrix = cell(18,1);
thisDsxnMatrix = cell(18,1);
for ii=1:2
    
    if ii==1
        thisData = plottingPixData;
    elseif ii==2
        thisData = plottingBranchData;
    end %if ii
    
    dataVector = [];
    count = 0;
    for jj=1:length(fields(thisData))
        dsxnName = ['dsxn',num2str(jj)];
        
        for kk=[2, 8, 3, 9, 4, 10, 5, 11, 6, 12, 7, 13]
            
            condName = ['cond',theConds{kk}];
            condSfx = condName(end-3:end);
            if strcmp(condSfx,'_24h')
                mm=1;
                count = count+1;
            elseif strcmp(condSfx,'_72h')
                mm=2;
            end %if strcmp
            
            thisDataMatrix(count,mm) = thisData.(dsxnName).(condName).mean;
            thisCondMatrix{count,1} = condName(1:end-4);
            thisDsxnMatrix{count,1} = dsxnName;
        end %for kk
        
    end %for jj
    
    if ii==1
        pixDataVector = thisDataMatrix;
        pixCondVector = thisCondMatrix;
        pixDsxnVector = thisDsxnMatrix;
    elseif ii==2
        branchDataVector = thisDataMatrix;
        branchCondVector = thisCondMatrix;
        branchDsxnVector = thisDsxnMatrix;
    end %if ii
    
end %for ii
clear thisData theseData dataVector;

% RM ANOVA TO GET INTERACTIONS
for ii=1:2
    
    if ii==1
        thisDataVector = pixDataVector;
        thisCondVector = pixCondVector;
        thisDsxnVector = pixDsxnVector;
    elseif ii==2
        thisDataVector = branchDataVector;
        thisCondVector = branchCondVector;
        thisDsxnVector = branchDsxnVector;
    end %if ii
    
    myTable = table(thisDataVector(:,1), thisDataVector(:,2), ...
        categorical(thisCondVector),categorical(thisDsxnVector),...
        'VariableNames', {'time24h','time72h','treatment','dissection'});
    
    Time = [1; 2];
    myTime = array2table(categorical(Time),'VariableNames',{'postInjTime'});
    
    rm.(theVars{ii}) = fitrm(myTable, 'time24h-time72h~treatment+dissection', 'WithinDesign', myTime);
    
    [tbl.(theVars{ii}), btwnSubj.(theVars{ii}), wthnSubj.(theVars{ii}), hypVal.(theVars{ii})] ...
        = ranova(rm.(theVars{ii}), 'WithinModel', 'postInjTime');
    
    [cTreatByTime.(theVars{ii})] = multcompare(rm.(theVars{ii}),'treatment','by','postInjTime');
    [cTimeByTreat.(theVars{ii})] = multcompare(rm.(theVars{ii}),'postInjTime','by','treatment');
    
    disp('')
    disp(theVars{ii});
    thisC = cTreatByTime.(theVars{ii});
    for jj=1:size(thisC,1)
        thisP = table2array(thisC(jj,6));
        if thisP<0.10
            idx1 = cellstr(table2array(thisC(jj,1)));
            idx2 = cellstr(table2array(thisC(jj,2)));
            idx3 = cellstr(table2array(thisC(jj,3)));
            col1 = idx1{1,1};
            col2 = idx2{1,1};
            col3 = idx3{1,1};
            disp('')
            dispThis = [col1, ' & ', col2, ' & ', col3, ', p=', num2str(thisP)];
            disp(dispThis);
        end %if thisP
    end %for jj
    disp('')
    thisC = cTimeByTreat.(theVars{ii});
    for jj=1:size(thisC,1)
        thisP = table2array(thisC(jj,6));
        if thisP<0.10
            idx1 = cellstr(table2array(thisC(jj,1)));
            idx2 = cellstr(table2array(thisC(jj,2)));
            idx3 = cellstr(table2array(thisC(jj,3)));
            col1 = idx1{1,1};
            col2 = idx2{1,1};
            col3 = idx3{1,1};
            disp('')
            dispThis = [col1, ' & ', col2, ' & ', col3, ', p=', num2str(thisP)];
            disp(dispThis);
        end %if thisP
    end %for jj
    
end %for ii
% RESULTS ! ! !
% pix
% 24h & cond0g50b & cond30g0b, p=0.044386
% 24h & cond0g50b & cond30g50b, p=0.081495
% 72h & cond0g50b & cond30g0b, p=0.079788
% cond0g0b & 24h & 72h, p=0.007587
% cond0g50b & 24h & 72h, p=0.015443
% BPs
% 24h & cond0g50b & cond30g0b, p=0.088489
% cond0g0b & 24h & 72h, p=0.05996
% cond0g50b & 24h & 72h, p=0.040294

%%
% doing RM anova a different way *** need to create an interaction term ***
clc;

% now do stats for only REPLICATE averages
thisDataMatrix = zeros(18,2);
thisCondMatrix = cell(18,1);
thisDsxnMatrix = cell(18,1);
thisTimeMatrix = cell(18,1);
for ii=1:2
    
    if ii==1
        thisData = plottingPixData;
    elseif ii==2
        thisData = plottingBranchData;
    end %if ii
    
    dataVector = [];
    count = 0;
    for jj=1:length(fields(thisData))
        dsxnName = ['dsxn',num2str(jj)];
        
        for kk=2:length(theConds)
            
            condName = ['cond',theConds{kk}];
            condSfx1 = condName(end-6:end-4);
            if strcmp(condSfx1,'g0b')
                mm=1;
                count = count+1;
            elseif strcmp(condSfx1,'50b')
                mm=2;
            end %if strcmp
            condSfx2 = condName(end-3:end);
            if strcmp(condSfx2,'_24h')
                thisTimeMatrix{count,1} = '24h';
            elseif strcmp(condSfx2,'_72h')
                thisTimeMatrix{count,1} = '72h';
            end %if strcmp
            
            thisDataMatrix(count,mm) = thisData.(dsxnName).(condName).mean;
            condIdx = strfind(theConds{kk},'g');
            thisCondMatrix{count,1} = ['cond',theConds{kk}(1:condIdx)];
            thisDsxnMatrix{count,1} = dsxnName;
        end %for kk
        
    end %for jj
    
    if ii==1
        pixDataVector = thisDataMatrix;
        pixCondVector = thisCondMatrix;
        pixDsxnVector = thisDsxnMatrix;
        pixTimeVector = thisTimeMatrix;
    elseif ii==2
        branchDataVector = thisDataMatrix;
        branchCondVector = thisCondMatrix;
        branchDsxnVector = thisDsxnMatrix;
        branchTimeVector = thisTimeMatrix;
    end %if ii
    
end %for ii
clear thisData theseData dataVector;

% RM ANOVA TO GET INTERACTIONS
for ii=1:2
    
    if ii==1
        thisDataVector = pixDataVector;
        thisCondVector = pixCondVector;
        thisDsxnVector = pixDsxnVector;
        thisTimeVector = pixTimeVector;
    elseif ii==2
        thisDataVector = branchDataVector;
        thisCondVector = branchCondVector;
        thisDsxnVector = branchDsxnVector;
        thisTimeVector = branchTimeVector;
    end %if ii
    
    myTable = table(thisDataVector(:,1), thisDataVector(:,2), ...
        categorical(thisCondVector),categorical(thisTimeVector),categorical(thisDsxnVector),...
        'VariableNames', {'treat0B','treat50B','injury','time','dissection'});
    
    Time = [1; 2];
    myTime = array2table(categorical(Time),'VariableNames',{'bdnfGroup'});
    
    rm.(theVars{ii}) = fitrm(myTable, 'treat0B-treat50B~injury*time+dissection', 'WithinDesign', myTime);
    
    [tbl.(theVars{ii}), btwnSubj.(theVars{ii}), wthnSubj.(theVars{ii}), hypVal.(theVars{ii})] ...
        = ranova(rm.(theVars{ii}), 'WithinModel', 'bdnfGroup');
    
    [cBdnfByInjury.(theVars{ii})] = multcompare(rm.(theVars{ii}),'bdnfGroup','by','injury');
    [cBdnfByTime.(theVars{ii})] = multcompare(rm.(theVars{ii}),'bdnfGroup','by','time');
    [cInjuryByBdnf.(theVars{ii})] = multcompare(rm.(theVars{ii}),'injury','by','bdnfGroup');
    [cTimeByBdnf.(theVars{ii})] = multcompare(rm.(theVars{ii}),'time','by','bdnfGroup');
    
    % *************************************
    % *** this didn't really work like I thought it would, but maybe it
    % could if the time variable were restricted (only comparing 24h to 24h
    % and 72h to 72h) ??? ***
    % *************************************
    %     injuryCell = categorical(thisCondVector);
    %     timeCell = categorical(thisTimeVector);
    %
    %     % 2. Create an interaction factor capturing each combination of levels % of Etype and Treatment (you can check with the function "catogories()")
    %     interaction_cat = injuryCell.*timeCell;
    %
    %     Time = [1; 2];
    %     myTime = array2table(categorical(Time),'VariableNames',{'bdnfGroup'});
    %
    %     % 3. Call fitrm with the modified between design.
    %     myTable2 = table(interaction_cat, thisDataVector(:,1), thisDataVector(:,2), ...
    %         'VariableNames', {'intrxn_injury_time', 'treat0B', 'treat50B'});
    %     rm2 = fitrm(myTable2, 'treat0B-treat50B ~ intrxn_injury_time', ...
    %         'WithinDesign', myTime);
    %     [tbl2, btwnSubj2, wthnSubj2, hypVal2] = ranova(rm2, 'WithinModel', 'bdnfGroup');
    %
    %     % 4. Use interaction factor interaction_cat as the first variable in % multcompare, 'By' Time
    %     [cInterByBDNF.(theVars{ii})] = multcompare(rm2,'intrxn_injury_time','By','bdnfGroup'); % * * * THIS IS IT ! ! ! * * * %
    %     [cBDNFByInter.(theVars{ii})] = multcompare(rm2,'bdnfGroup','By','intrxn_injury_time'); % * * * THIS IS IT ! ! ! * * * %
    %
    %
    %     disp('')
    %     disp(theVars{ii});
    %     thisC = cInterByBDNF.(theVars{ii});
    %     for jj=1:size(thisC,1)
    %         thisP = table2array(thisC(jj,6));
    %         if thisP<0.10
    %             idx1 = cellstr(table2array(thisC(jj,1)));
    %             idx2 = cellstr(table2array(thisC(jj,2)));
    %             idx3 = cellstr(table2array(thisC(jj,3)));
    %             col1 = idx1{1,1};
    %             col2 = idx2{1,1};
    %             col3 = idx3{1,1};
    %             disp('')
    %             dispThis = [col1, ' & ', col2, ' & ', col3, ', p=', num2str(thisP)];
    %             disp(dispThis);
    %         end %if thisP
    %     end %for jj
    %     disp('')
    %     thisC = cBDNFByInter.(theVars{ii});
    %     for jj=1:size(thisC,1)
    %         thisP = table2array(thisC(jj,6));
    %         if thisP<0.10
    %             idx1 = cellstr(table2array(thisC(jj,1)));
    %             idx2 = cellstr(table2array(thisC(jj,2)));
    %             idx3 = cellstr(table2array(thisC(jj,3)));
    %             col1 = idx1{1,1};
    %             col2 = idx2{1,1};
    %             col3 = idx3{1,1};
    %             disp('')
    %             dispThis = [col1, ' & ', col2, ' & ', col3, ', p=', num2str(thisP)];
    %             disp(dispThis);
    %         end %if thisP
    %     end %for jj
    %
end %for ii
% RESULTS ! ! ! with interaction
% pix
% cond0g 24h & 0B & 50B, p=0.046416
% cond0g 72h & 0B & 50B, p=0.010446
% BPs
% cond0g 24h & 0B & 50B, p=0.033468
% cond0g 72h & 0B & 50B, p=0.07529
%% one more way -- interaction for injury & treatment
clc;

% now do stats for only REPLICATE averages
thisDataMatrix = zeros(18,2);
thisBdnfMatrix = cell(18,1);
thisInjMatrix = cell(18,1);
thisDsxnMatrix = cell(18,1);
for ii=1:2
    
    if ii==1
        thisData = plottingPixData;
    elseif ii==2
        thisData = plottingBranchData;
    end %if ii
    
    dataVector = [];
    count = 0;
    for jj=1:length(fields(thisData))
        dsxnName = ['dsxn',num2str(jj)];
        
        for kk=[2, 8, 3, 9, 4, 10, 5, 11, 6, 12, 7, 13]
            condName = ['cond',theConds{kk}];
            
            condSfx1 = condName(end-3:end);
            if strcmp(condSfx1,'_24h')
                mm=1;
                count = count+1;
            elseif strcmp(condSfx1,'_72h')
                mm=2;
            end %if strcmp
            
            condSfx2 = condName(end-6:end-4);
            if strcmp(condSfx2,'g0b')
                thisBdnfMatrix{count,1} = '0B';
            elseif strcmp(condSfx2,'50b')
                thisBdnfMatrix{count,1} = '50B';
            end %if strcmp
            
            thisDataMatrix(count,mm) = thisData.(dsxnName).(condName).mean;
            thisDsxnMatrix{count,1} = dsxnName;
            condIdx = strfind(theConds{kk},'g');
            thisInjMatrix{count,1} = ['cond',theConds{kk}(1:condIdx)];

        end %for kk
        
    end %for jj
    
    if ii==1
        pixDataVector = thisDataMatrix;
        pixBdnfVector = thisBdnfMatrix;
        pixInjVector = thisInjMatrix;
        pixDsxnVector = thisDsxnMatrix;
    elseif ii==2
        branchDataVector = thisDataMatrix;
        branchBdnfVector = thisBdnfMatrix;
        branchInjVector = thisInjMatrix;
        branchDsxnVector = thisDsxnMatrix;
    end %if ii
    
end %for ii
clear thisData theseData dataVector;

% RM ANOVA TO GET INTERACTIONS

for ii=1:2
    
    if ii==1
        thisDataVector = pixDataVector;
        thisBdnfVector = pixBdnfVector;
        thisInjVector = pixInjVector;
        thisDsxnVector = pixDsxnVector;
    elseif ii==2
        thisDataVector = branchDataVector;
        thisBdnfVector = branchBdnfVector;
        thisInjVector = branchInjVector;
        thisDsxnVector = pixDsxnVector;
    end %if ii
    
    myTable = table(thisDataVector(:,1), thisDataVector(:,2), ...
        categorical(thisBdnfVector),categorical(thisInjVector),categorical(thisDsxnVector),...
        'VariableNames', {'post24h','post72h','bdnf','injury','dissection'});
    
    Time = [1; 2];
    myTime = array2table(categorical(Time),'VariableNames',{'postInjTime'});
    
    rm.(theVars{ii}) = fitrm(myTable, 'post24h-post72h~bdnf*injury+dissection', 'WithinDesign', myTime);
    
    [tbl.(theVars{ii}), btwnSubj.(theVars{ii}), wthnSubj.(theVars{ii}), hypVal.(theVars{ii})] ...
        = ranova(rm.(theVars{ii}), 'WithinModel', 'postInjTime');
    
    injuryCell = categorical(thisInjVector);
    bdnfCell = categorical(thisBdnfVector);
    
    % 2. Create an interaction factor capturing each combination of levels % of Etype and Treatment (you can check with the function "catogories()")
    interaction_cat = injuryCell.*bdnfCell;
    
    Time = [1; 2];
    myTime = array2table(categorical(Time),'VariableNames',{'postInjTime'});
    
    % 3. Call fitrm with the modified between design.
    myTable2 = table(interaction_cat, thisDataVector(:,1), thisDataVector(:,2), ...
        'VariableNames', {'intrxn_injury_bdnf', 'post24h', 'post72h'});
    rm2 = fitrm(myTable2, 'post24h-post72h ~ intrxn_injury_bdnf', ...
        'WithinDesign', myTime);
    [tbl2, btwnSubj2, wthnSubj2, hypVal2] = ranova(rm2, 'WithinModel', 'postInjTime');
    
    % 4. Use interaction factor interaction_cat as the first variable in % multcompare, 'By' Time
    [cInterByTime.(theVars{ii})] = multcompare(rm2,'intrxn_injury_bdnf','By','postInjTime'); % * * * THIS IS IT ! ! ! * * * %
    [cTimeByInter.(theVars{ii})] = multcompare(rm2,'postInjTime','By','intrxn_injury_bdnf'); % * * * THIS IS IT ! ! ! * * * %
    
    
    disp('')
    disp(theVars{ii});
    thisC = cInterByTime.(theVars{ii});
    for jj=1:size(thisC,1)
        thisP = table2array(thisC(jj,6));
        if thisP<0.10
            idx1 = cellstr(table2array(thisC(jj,1)));
            idx2 = cellstr(table2array(thisC(jj,2)));
            idx3 = cellstr(table2array(thisC(jj,3)));
            col1 = idx1{1,1};
            col2 = idx2{1,1};
            col3 = idx3{1,1};
            disp('')
            dispThis = [col1, ' & ', col2, ' & ', col3, ', p=', num2str(thisP)];
            disp(dispThis);
        end %if thisP
    end %for jj
    disp('')
    thisC = cTimeByInter.(theVars{ii});
    for jj=1:size(thisC,1)
        thisP = table2array(thisC(jj,6));
        if thisP<0.10
            idx1 = cellstr(table2array(thisC(jj,1)));
            idx2 = cellstr(table2array(thisC(jj,2)));
            idx3 = cellstr(table2array(thisC(jj,3)));
            col1 = idx1{1,1};
            col2 = idx2{1,1};
            col3 = idx3{1,1};
            disp('')
            dispThis = [col1, ' & ', col2, ' & ', col3, ', p=', num2str(thisP)];
            disp(dispThis);
        end %if thisP
    end %for jj
    
end %for ii
% RESULTS ! ! !
% pix
% cond0g 0B & 24h & 72h, p=0.013649
% cond0g 50B & 24h & 72h, p=0.026657
% BPs
% cond0g 0B & 24h & 72h, p=0.063736
% cond0g 50B & 24h & 72h, p=0.042592