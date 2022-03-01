import 'package:flutter/material.dart';
import 'package:ruby_robbery/l10n/l10n.dart';
import 'package:ruby_robbery/widgets/screen_box.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.privacyPolicy),),
      body: ScreenBox(
        child: _privacyPolicy(context),
      ),
    );
  }

  Widget _privacyPolicy(BuildContext context) {
    if (Localizations.localeOf(context).languageCode == 'de') {
      return _privacyPolicyDE();
    } else {
      return _privacyPolicyEN();
    }
  }

  Widget _privacyPolicyDE() {
    return PageView(scrollDirection: Axis.vertical, children: <Widget>[
      ListView(
          children: const [
            ListTile(
              title: Text('Datenschutzerklärung'),
              subtitle: Text(
                  'Das Spiel Rubin Raub erhebt keinerlei Nutzerdaten. In-Game Käufe werden über etablierte Drittanbieter abgehandelt, wie weiter unten spezifiziert.\n' +
                      'Im Folgenden wird ein Überblick gegeben, in welcher Form und welchem Umfang diese Verarbeitung geschieht, sowie auf die Rechte hingewiesen, die nach der Europäischen Datenschutz-Grundverordnung (DSGVO) und dem Bundesdatenschutzgesetzt (BDSG) gewährt werden.\n' +
                      'Wenn Fragen oder Anregungen zu diesen Informationen bestehen oder ein Ansprechpartner für das Geltendmachen von Rechten benötigt wird, Anfragen bitte richten an\n' +

                      'Fenja Hanisch\n' +
                      'Immenbarg 10\n' +
                      'fenja.harbke(at)googlemail.com'
              ),
            ),
            ListTile(
              title: Text('Allgemeine Angaben zur Datenverarbeitung'),
              subtitle: Text(
                  'Ich verarbeite personenbezogene Daten unter Beachtung der einschlägigen Datenschutzvorschriften, insbesondere der DSGVO und des BDSG. Eine Datenverarbeitung durch mich findet nur auf der Grundlage einer gesetzlichen Erlaubnis statt. ' +
                      'Bei der Nutzung dieser Anwendung werden personenbezogene Daten nur mit Einwilligung verarbeitet (Art. 6 Abs. 1 Buchst. a) DSGVO). zur Erfüllung eines Vertrags, dessen Vertragspartei der Nutzer darstellt, oder auf dessen Anfrage zur Durchführung ' +
                      'vorvertraglicher Maßnahmen (Art. 6 Abs. 1 Buchst. b) DSGVO), zur Erfüllung einer rechtlichen Verpflichtung (Art. 6 Abs. 1 Buchst c) DSGVO) oder wenn die Verarbeitung zur Wahrung meiner berechtigten Interessen oder den berechtigten Interessen eines ' +
                      'Dritten erforderlich ist, sofern nicht die Interessen des Nutzers, seine Grundrecht und Grundfreiheiten, die den Schutz personenbezogener Daten erfordern, überwiegen.'
              ),
            ),
            ListTile(
              title: Text('Dauer der Speicherung'),
              subtitle: Text(
                  'Sofern sich aus den folgenden Hinweisen nichts anderes ergibt, speichere ich die Daten nur so lange, wie es zur Erreichung des Verarbeitungszwecks oder für die Erfüllung meiner vertraglichen oder gesetzlichen Pflichten erforderlich ist. ' +
                      'Solche gesetzlichen Aufbewahrungspflichten können sich insbesondere aus handels- oder steuerrechtlichen Vorschriften ergeben.'
              ),
            ),
            ListTile(
              title: Text('Verarbeitung von Server-Log-Files'),
              subtitle: Text(
                  'Beim Spielen von Rubin Raub über den Browser werden zunächst automatisiert (also nicht über eine Registrierung) allgemeine Informationen gespeichert, die der Browser an den Server übermittelt. Hierzu zählen standardmäßig: Browsertyp/ -version, ' +
                      'verwendetes Betriebssystem, die aufgerufene Seite, die zuvor besuchte Seite (Referrer URL), IP-Adresse, Datum und Uhrzeit der Serveranfrage und http-Statuscode. Die Verarbeitung erfolgt zur Wahrung meiner berechtigten Interessen und beruht auf der ' +
                      'Rechtsgrundlage des Art. 6 Abs. 1 Buchst. f) DSGVO. Diese Verarbeitung dient der technischen Verwaltung und der Sicherheit der Webseite. Die gespeicherten Daten werden gelöscht, wenn nicht aufgrund konreter Anhaltspunkte ein berechtigter Verdacht ' +
                      'auf eine rechtswidrige Nutzung besteht und eine weitere Prüfung und Verarbeitung der Informationen aus diesem Grund erforderlich ist.'
              ),
            ),
            ListTile(
              title: Text('Sicherheit der Datenverarbeitung'),
              subtitle: Text(
                  'Um personenbezogene Daten zu schützen wurden sowohl technische, als auch organisatorische Maßnahmen umgesetzt. Wo es möglich ist werden personenbezogene Daten pseudonymisiert oder verschlüsselt. Dadurch wird es im Rahmen meiner Möglichkeiten erschwert, ' +
                      'dass Dritte aus meinen Daten auf persönliche Informationen schließen können.'
              ),
            ),
            ListTile(
              title: Text('Kommunikation'),
              subtitle: Text(
                  'Bei der Kontaktaufnahme zu mir per Email oder Online-Formular kann es zur Verarbeitung personenbezogener Daten kommen.\n' +
                      'Die Daten werden für die Abwicklung und Bearbeitung der Frage und des damit zusammenhängenden Geschäftsvorgangs verarbeitet. Die Daten werden ebensolange gespeichert bzw. so lange es das Gesetz vorschreibt.'
              ),
            ),
            ListTile(
              title: Text('Warum werden personenbezogene Daten verarbeitet?'),
              subtitle: Text(
                  'In der Zukunft werden In-Game käufe möglich sein. Entsprechend wird dieser Abschnitt dann ergänzt werden.'),
            ),
            ListTile(
              title: Text('Firebase'),
              subtitle: Text('Rubin Raub nutzt Firebase von Google.\n'
                  'Die Datenschutzerklärung von Google kann hier eingesehen werden: https://policies.google.com/privacy'),
            ),
            ListTile(
              title: Text('Beschwerde bei einer Aufsichtsbehörde'),
              subtitle: Text(
                  'Wenn der Nutzer der Ansicht ist, dass eine Verarbeitung der ihn betreffenden, personenbezogenen Daten gegen die Bestimmungen der DSGVO verstößt, hat er nach Maßgabe des Art. 77 DSGVO das Recht auf Beschwerde bei einer Aufsichtsbehörde.'),
            )
          ])
    ]);
  }


  Widget _privacyPolicyEN() {
    return PageView(scrollDirection: Axis.vertical, children: <Widget>[
      ListView(
          children: const [
            ListTile(
              title: Text('Privacy Policy'),
              subtitle: Text(
                  'eThe game Ruby Robbery can be used does not raise any data about it’s players. In-app purchases are processed by established plugins as detailed below.\n' +
                      'I will give an overview on the form and scope which is used by processing, as well as direct to the rights given by the european General Data Protection Regulation (GDPR, german DSGVO) and the german Federal Data Protection Act (BDSG).\n' +
                      'In case of questions or suggestions regarding this information or there is need for a contact to make use of the rights given, please contact the developer:\n' +

                      'Fenja Hanisch\n' +
                      'Immenbarg 10\n' +
                      'fenja.harbke(at)googlemail.com'
              ),
            ),
            ListTile(
              title: Text('General information regarding data processing'),
              subtitle: Text(
                  'If not specified in more detail, data is stored as long as it is needed to reach their purpose of treatment or the purpose to fulfill my contract or legal duties. Legal duties of storage may grow from instructions of law of trade or taxation.'
              ),
            ),
            ListTile(
              title: Text('Processing server log files'),
              subtitle: Text(
                  'When playing Ruby Robbery, the browser automatically transfers general information to the server (that is without any registration). This includes by default: browser type and version, ' +
                      'operating system, the page requested, the page visited before (referer URL), IP address, date and time of the server request, as well as the http response code. The procession is justified through my ' +
                      'legal interests and based on the legal law of Art. 6 Abs. 1 Buchst. f) DSGVO. This procession is needed for technical administration and the web applications security. Saved data will be deleted, ' +
                      'when there is no actual reason to suspect an illegal performance that would require additional examination an procression of the informations for this very reason.'
              ),
            ),
            ListTile(
              title: Text('Security of data procession'),
              subtitle: Text(
                  'To protect personal data, technical and organizational requirements are fulfilled. Whenever possible, personal data is encrypted or de-personalized. This - in the scope of my possibilites - hinders third parties to gain access from my data to personal informations from the user.'
              ),
            ),
            ListTile(
              title: Text('Communication'),
              subtitle: Text(
                  'During contact to me via email or form, personal data may be processed.\n' +
                      'The data will be processed to answer and execute the requests and connected business processes. Data will be saved as long as needed or as legally required.'
              ),
            ),
            ListTile(
              title: Text('Why is personal data processed?'),
              subtitle: Text(
                  'In the future, personal data will be processed to perform in-app purchases.'),
            ),
            ListTile(
              title: Text('Firebase'),
              subtitle: Text(
                  'RRuby Robbery uses Googles Firebase to host the web version of the game.\n' +
                      'Google privacy policy can be read here: https://policies.google.com/privacy'),
            ),
            ListTile(
              title: Text('Complain at a surveillance authority'),
              subtitle: Text(
                  'If, in the users optinion, the processing of his personal data violates the requirements of the DSGVO, he is able to file a complaint at the surveillance authority, according to requirement of Art. 77 DSGVO.'),
            )
          ])
    ]);
  }
}
