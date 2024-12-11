import 'package:flutter/material.dart';
import 'package:nom_order/widgets/custom_appbar.dart';
import 'dart:io' show Platform;

import '../../data/theme_setting.dart';

class Legalese extends StatelessWidget {
  final ThemeSetting themeSetting;
  const Legalese({super.key, required this.themeSetting});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeSetting.background,
      appBar: CustomAppBar(title: "Terms & Conditions", bottomBorder: true, themeSetting: themeSetting),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(bottom: 100),
          margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Text(
            legalese,
            style: TextStyle(
              color: themeSetting.textBody,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
const String eula = '''
\n\nEULA

Apps made available through the App Store are licensed, not sold, to you. Your license to each App is subject to your prior acceptance of either this Licensed Application End User License Agreement (“Standard EULA”), or a custom end user license agreement between you and the Application Provider (“Custom EULA”), if one is provided. Your license to any Apple App under this Standard EULA or Custom EULA is granted by Apple, and your license to any Third Party App under this Standard EULA or Custom EULA is granted by the Application Provider of that Third Party App. Any App that is subject to this Standard EULA is referred to herein as the “Licensed Application.” The Application Provider or Apple as applicable (“Licensor”) reserves all rights in and to the Licensed Application not expressly granted to you under this Standard EULA.

a. Scope of License: Licensor grants to you a nontransferable license to use the Licensed Application on any Apple-branded products that you own or control and as permitted by the Usage Rules. The terms of this Standard EULA will govern any content, materials, or services accessible from or purchased within the Licensed Application as well as upgrades provided by Licensor that replace or supplement the original Licensed Application, unless such upgrade is accompanied by a Custom EULA. Except as provided in the Usage Rules, you may not distribute or make the Licensed Application available over a network where it could be used by multiple devices at the same time. You may not transfer, redistribute or sublicense the Licensed Application and, if you sell your Apple Device to a third party, you must remove the Licensed Application from the Apple Device before doing so. You may not copy (except as permitted by this license and the Usage Rules), reverse-engineer, disassemble, attempt to derive the source code of, modify, or create derivative works of the Licensed Application, any updates, or any part thereof (except as and only to the extent that any foregoing restriction is prohibited by applicable law or to the extent as may be permitted by the licensing terms governing use of any open-sourced components included with the Licensed Application).

b. Consent to Use of Data: You agree that Licensor may collect and use technical data and related information—including but not limited to technical information about your device, system and application software, and peripherals—that is gathered periodically to facilitate the provision of software updates, product support, and other services to you (if any) related to the Licensed Application. Licensor may use this information, as long as it is in a form that does not personally identify you, to improve its products or to provide services or technologies to you.

c. Termination. This Standard EULA is effective until terminated by you or Licensor. Your rights under this Standard EULA will terminate automatically if you fail to comply with any of its terms. 

d. External Services. The Licensed Application may enable access to Licensor’s and/or third-party services and websites (collectively and individually, "External Services"). You agree to use the External Services at your sole risk. Licensor is not responsible for examining or evaluating the content or accuracy of any third-party External Services, and shall not be liable for any such third-party External Services. Data displayed by any Licensed Application or External Service, including but not limited to financial, medical and location information, is for general informational purposes only and is not guaranteed by Licensor or its agents. You will not use the External Services in any manner that is inconsistent with the terms of this Standard EULA or that infringes the intellectual property rights of Licensor or any third party. You agree not to use the External Services to harass, abuse, stalk, threaten or defame any person or entity, and that Licensor is not responsible for any such use. External Services may not be available in all languages or in your Home Country, and may not be appropriate or available for use in any particular location. To the extent you choose to use such External Services, you are solely responsible for compliance with any applicable laws. Licensor reserves the right to change, suspend, remove, disable or impose access restrictions or limits on any External Services at any time without notice or liability to you. 

e. NO WARRANTY: YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT USE OF THE LICENSED APPLICATION IS AT YOUR SOLE RISK. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THE LICENSED APPLICATION AND ANY SERVICES PERFORMED OR PROVIDED BY THE LICENSED APPLICATION ARE PROVIDED "AS IS" AND “AS AVAILABLE,” WITH ALL FAULTS AND WITHOUT WARRANTY OF ANY KIND, AND LICENSOR HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS WITH RESPECT TO THE LICENSED APPLICATION AND ANY SERVICES, EITHER EXPRESS, IMPLIED, OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES AND/OR CONDITIONS OF MERCHANTABILITY, OF SATISFACTORY QUALITY, OF FITNESS FOR A PARTICULAR PURPOSE, OF ACCURACY, OF QUIET ENJOYMENT, AND OF NONINFRINGEMENT OF THIRD-PARTY RIGHTS. NO ORAL OR WRITTEN INFORMATION OR ADVICE GIVEN BY LICENSOR OR ITS AUTHORIZED REPRESENTATIVE SHALL CREATE A WARRANTY. SHOULD THE LICENSED APPLICATION OR SERVICES PROVE DEFECTIVE, YOU ASSUME THE ENTIRE COST OF ALL NECESSARY SERVICING, REPAIR, OR CORRECTION. SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OF IMPLIED WARRANTIES OR LIMITATIONS ON APPLICABLE STATUTORY RIGHTS OF A CONSUMER, SO THE ABOVE EXCLUSION AND LIMITATIONS MAY NOT APPLY TO YOU.

f. Limitation of Liability. TO THE EXTENT NOT PROHIBITED BY LAW, IN NO EVENT SHALL LICENSOR BE LIABLE FOR PERSONAL INJURY OR ANY INCIDENTAL, SPECIAL, INDIRECT, OR CONSEQUENTIAL DAMAGES WHATSOEVER, INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF PROFITS, LOSS OF DATA, BUSINESS INTERRUPTION, OR ANY OTHER COMMERCIAL DAMAGES OR LOSSES, ARISING OUT OF OR RELATED TO YOUR USE OF OR INABILITY TO USE THE LICENSED APPLICATION, HOWEVER CAUSED, REGARDLESS OF THE THEORY OF LIABILITY (CONTRACT, TORT, OR OTHERWISE) AND EVEN IF LICENSOR HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. SOME JURISDICTIONS DO NOT ALLOW THE LIMITATION OF LIABILITY FOR PERSONAL INJURY, OR OF INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THIS LIMITATION MAY NOT APPLY TO YOU. In no event shall Licensor’s total liability to you for all damages (other than as may be required by applicable law in cases involving personal injury) exceed the amount of fifty dollars (\$50.00). The foregoing limitations will apply even if the above stated remedy fails of its essential purpose.

g. You may not use or otherwise export or re-export the Licensed Application except as authorized by United States law and the laws of the jurisdiction in which the Licensed Application was obtained. In particular, but without limitation, the Licensed Application may not be exported or re-exported (a) into any U.S.-embargoed countries or (b) to anyone on the U.S. Treasury Department's Specially Designated Nationals List or the U.S. Department of Commerce Denied Persons List or Entity List. By using the Licensed Application, you represent and warrant that you are not located in any such country or on any such list. You also agree that you will not use these products for any purposes prohibited by United States law, including, without limitation, the development, design, manufacture, or production of nuclear, missile, or chemical or biological weapons.

h. The Licensed Application and related documentation are "Commercial Items", as that term is defined at 48 C.F.R. §2.101, consisting of "Commercial Computer Software" and "Commercial Computer Software Documentation", as such terms are used in 48 C.F.R. §12.212 or 48 C.F.R. §227.7202, as applicable. Consistent with 48 C.F.R. §12.212 or 48 C.F.R. §227.7202-1 through 227.7202-4, as applicable, the Commercial Computer Software and Commercial Computer Software Documentation are being licensed to U.S. Government end users (a) only as Commercial Items and (b) with only those rights as are granted to all other end users pursuant to the terms and conditions herein. Unpublished-rights reserved under the copyright laws of the United States.

i. Except to the extent expressly provided in the following paragraph, this Agreement and the relationship between you and Apple shall be governed by the laws of the State of California, excluding its conflicts of law provisions. You and Apple agree to submit to the personal and exclusive jurisdiction of the courts located within the county of Santa Clara, California, to resolve any dispute or claim arising from this Agreement. If (a) you are not a U.S. citizen; (b) you do not reside in the U.S.; (c) you are not accessing the Service from the U.S.; and (d) you are a citizen of one of the countries identified below, you hereby agree that any dispute or claim arising from this Agreement shall be governed by the applicable law set forth below, without regard to any conflict of law provisions, and you hereby irrevocably submit to the non-exclusive jurisdiction of the courts located in the state, province or country identified below whose law governs:

If you are a citizen of any European Union country or Switzerland, Norway or Iceland, the governing law and forum shall be the laws and courts of your usual place of residence.

Specifically excluded from application to this Agreement is that law known as the United Nations Convention on the International Sale of Goods.
''';
const String legalese = '''
Terms & Conditions

Note: the Privacy Policy is included in section 4.

1. Summary
Wordoss earn money from subscriptions or ads. Data from messages are stored in a third-party database, and are not encrypted.

2. About us
Wordoss is a language learning app with the purpose of providing people a platform for learning effectively in one or more target languages using AI. Wordoss earns money from both advertisement on the platform or premium memberships paid by users. The app was created by Wordoss, a company based in Copenhagen, Denmark.

Our goal is to create a free platform for language learners, that delivers great results for all kinds of users. We intend to fulfill this goal by incorporating: 
	
	AI-powered learning.
	Support many languages.
	A premium price, that suits people anywhere.
	A great & beautiful user interface.


3. Access
By accessing the app Wordoss by signing in or registering, you confirm, that you are 18 years or older or have a parent or guardian, who takes responsibility for your agreement of these terms & conditions. Also, you confirm, that you have read the Terms & Conditions, and you acknowledge that by using the services we provide, you hereby agree to our terms and Privacy Policy, and understand that you are bound by these terms until the terms have changed.

If you do not agree to the terms, you will not be able to register, and if you already own an account for this service and yet do not agree to the terms, we inform you, that you already have agreed by registering.

In order to access the platform and the service we provide, you must sign in with an email and a password. You are responsible for your own account, and must not share it with other people. Any unauthorized use of your account must be reported to Wordoss via our email frederikwordoss@gmail.com. With an account you agree that other people may find your user on the platform via your email address. After signing in, you understand, that Wordoss can send notifications to you.

4. Privacy Policy
Wordoss strives to protect the privacy and security of our users personal information. When you use the Wordoss platform, we collect personal information, that could be used to identify you. Any personal information from your account is covered by our Privacy Policy. 
We collect personal data on the following:
	
	your name (if you provide it)
	your email address
	your password via third party authentication, which means we cannot see it.
	your last login date and time
	your first login date and time
		
Other data we collect:
	
	the languages you are learning and speak
	the words you have learned and how well
	your message history with the AI

We might use your personal information to perform data analytics, that will play part in improving our platform. Furthermore, we might use your personal information to serve you ads, emails or push notifications.


5. Responsible use and conduct
By registering to the platform Wordoss provides, you agree to use the platform for the purpose intended, and you understand the following:

	By registering or using your account, you agree that the email and other account 	information are accurate, belongs to you and are up to date. You agree that you are responsible for all activities on your account and maintaining the confidentiality of login information. You agree that any unauthorized access on your account or that you perform, that Wordoss directly or indirectly suffers from, will hold you liable.

	We have the right to take appropriate action, where user behaviour is, by us, seen as harmful, inaccurate or violates rights in any way. This includes removing or suspending your account from our platform
	
	Attempting to gain from the platform in a way, that includes copying or duplicating the app is prohibited.

6. Subscriptions
Wordoss Premium is an auto-renewing subscription plan, that grants the account features as specified on the plan selection page. The subscription will be charged to your credit card through either your Itunes Account or Play Store account.\n
You will be charged for a renewal of the subscription within 24-hours prior to the end of the period selected. Your subscription can be managed in Account Settings after purchase.

7. Use of AI in the app
The app uses AI-services provided by 3rd parties for these services:
  - Text to speech
  - Text completion

8. Deleting your account
It is possible to have your account deleted on the app in the settings, and if your account has been suspended, it is possible to have it deleted by contacting Wordoss at frederikwordoss@gmail.com. User data for inactive accounts of more than 1 year are deleted every year.

Note, that the service is provided “as is”, without warranty of any kind. In no event shall Wordoss or Wordoss be held liable for any claim, damages or other liability caused by a user.
''';
