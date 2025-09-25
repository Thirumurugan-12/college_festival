import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/category_detail_screen.dart';
import '../models/category_models.dart';

class AppRoutes {
  static const String home = '/';
  static const String singing = '/singing';
  static const String acting = '/acting';
  static const String dancing = '/dancing';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: singing,
        builder: (context, state) => CategoryDetailScreen(
          data: _getSingingData(),
          imageAsset: 'lib/assets/singing.png',
        ),
      ),
      GoRoute(
        path: acting,
        builder: (context, state) => CategoryDetailScreen(
          data: _getActingData(),
          imageAsset: 'lib/assets/acting.png',
        ),
      ),
      GoRoute(
        path: dancing,
        builder: (context, state) => CategoryDetailScreen(
          data: _getDancingData(),
          imageAsset: 'lib/assets/dance.png',
        ),
      ),
    ],
  );

  static CategoryDetailData _getSingingData() {
    return CategoryDetailData(
      categoryName: 'Singing',
      mode: '100% Online',
      participants: 'College students across Tamil Nadu',
      timeline: '30 Days',
      entryFormat: EntryFormat(
        type: 'Solo Singing',
        duration: 'Maximum 2 minutes per performance',
        language: 'Tamil',
        style: 'Original compositions or Cover songs allowed',
        submissionFormat: 'Video',
        songSelection: const [
          'Ennavale Adi Ennavale – Kadhalan',
          'Unnai Kaanadhu Naan – Vishwaroopam',
          'Kanne Kalaimane – Moondram Pirai',
          'Mandram Vandha – Mouna Ragam',
          'Chinna Chinna Vannakuyil – Mouna Ragam',
          'Ilaya Nila – Payanangal Mudivathillai',
          'Malargale Malargale – Love Birds',
          'Putham Pudhu Kaalai – Alaigal Oivathillai',
          'Paadariyen Padippariyen – Sindhu Bhairavi',
          'Raja Raja Chozhan – Rettai Vaal Kuruvi',
          'Tum Tum – Enemy',
          'Vaathi Coming – Master',
          'Naan Pizhai – Kaathuvaakula Rendu Kaadhal',
          'Mallipoo – Vendhu Thanindhathu Kaadu',
          'Aalaporan Tamizhan – Mersal',
          'So Baby – Doctor',
          'Kaarkuzhal Kadavaiye – Karnan',
          'Aval – Manithan',
          'Adiye – Bachelor',
          'Vaa Vaathi – Vaathi',
        ],
      ),
      rules: const [
        'One Entry Per Participant',
        'Fresh Recordings Only',
        'No Auto-tuning or Voice Modifications',
        'Background Tracks Allowed',
        'Songs with hate speech, explicit content, or plagiarism will be disqualified',
        'Face and voice must match; no lip-syncing',
        'No bots or fake accounts for audience votes',
      ],
      judgingCriteria: const [
        JudgingCriterion('Vocal Quality', 30),
        JudgingCriterion('Pitch & Rhythm', 25),
        JudgingCriterion('Expression & Emotion', 20),
        JudgingCriterion('Creativity & Song Choice', 15),
        JudgingCriterion('Overall Presentation', 10),
      ],
      awards: const Awards(
        winner:
            '20,000 INR Cash Prize + Trophy + Certificate + Digital Badge + Social Media Feature',
        runnerUp: '5,000 INR Cash Prize + Certificate + Digital Badge',
        audienceChoice: '2,500 INR Cash Prize + Certificate + Digital Badge',
        topCollege: 'College-level Trophy for highest participation',
      ),
      voting: Voting(
        deadline: DateTime(2025, 11, 5, 23, 59, 59),
        platform: 'College Thiruvizha Website',
        notes: 'One vote per entry per user',
      ),
      juryPanel: const [
        'Playback Singers',
        'Music Directors',
        'Creedom Pro Mentors',
      ],
      importantNotes: const [
        'Rights for winning entries remain with participants',
        'College Thiruvizha may showcase entries on official platforms',
        'Certificates will be issued digitally; trophies & prizes shipped to colleges',
      ],
    );
  }

  static CategoryDetailData _getActingData() {
    return CategoryDetailData(
      categoryName: 'Acting',
      mode: '100% Online',
      participants: 'College students across Tamil Nadu',
      timeline: '30 Days',
      entryFormat: const EntryFormat(
        type: 'Solo/Group Acting',
        duration: 'Maximum 3 minutes per performance',
        language: 'Tamil/English',
        style: 'Drama, Comedy, or Monologue',
        submissionFormat: 'Video',
      ),
      rules: const [
        'One Entry Per Participant',
        'Original scripts preferred',
        'No explicit or inappropriate content',
        'Props and costumes allowed',
      ],
      judgingCriteria: const [
        JudgingCriterion('Acting Skills', 30),
        JudgingCriterion('Script & Dialogue', 25),
        JudgingCriterion('Expression & Emotion', 20),
        JudgingCriterion('Costume & Props', 15),
        JudgingCriterion('Overall Impact', 10),
      ],
      awards: const Awards(
        winner: 'TBA',
        runnerUp: 'TBA',
        audienceChoice: 'TBA',
        topCollege: 'TBA',
      ),
      voting: Voting(
        deadline: DateTime(2025, 11, 5, 23, 59, 59),
        platform: 'College Thiruvizha Website',
        notes: 'One vote per entry per user',
      ),
      juryPanel: const ['Professional Actors', 'Directors', 'Theater Artists'],
      importantNotes: const ['Details to be announced.'],
    );
  }

  static CategoryDetailData _getDancingData() {
    return CategoryDetailData(
      categoryName: 'Dance',
      mode: '100% Online',
      participants: 'College students across Tamil Nadu',
      timeline: '30 Days',
      entryFormat: const EntryFormat(
        type: 'Solo/Group Dance',
        duration: 'Maximum 3 minutes per performance',
        language: '-',
        style: 'Classical, Folk, or Contemporary',
        submissionFormat: 'Video',
      ),
      rules: const [
        'One Entry Per Participant',
        'Original choreography preferred',
        'No explicit or inappropriate content',
        'Traditional or contemporary styles allowed',
      ],
      judgingCriteria: const [
        JudgingCriterion('Technique & Skills', 30),
        JudgingCriterion('Choreography & Creativity', 25),
        JudgingCriterion('Expression & Performance', 20),
        JudgingCriterion('Costume & Presentation', 15),
        JudgingCriterion('Overall Impact', 10),
      ],
      awards: const Awards(
        winner: 'TBA',
        runnerUp: 'TBA',
        audienceChoice: 'TBA',
        topCollege: 'TBA',
      ),
      voting: Voting(
        deadline: DateTime(2025, 11, 5, 23, 59, 59),
        platform: 'College Thiruvizha Website',
        notes: 'One vote per entry per user',
      ),
      juryPanel: const [
        'Professional Dancers',
        'Choreographers',
        'Cultural Experts',
      ],
      importantNotes: const ['Details to be announced.'],
    );
  }
}
