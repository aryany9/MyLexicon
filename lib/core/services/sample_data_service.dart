import '../../models/lexicon_collection.dart';
import '../../models/lexicon_entry.dart';
import '../../models/lexicon_type.dart';
import 'database_service.dart';

class SampleLoadResult {
  final int added;
  final int updated;
  final int skipped;

  const SampleLoadResult({
    required this.added,
    required this.updated,
    required this.skipped,
  });

  int get totalAffected => added + updated;
}

class SampleDataService {
  SampleDataService._();

  static List<LexiconCollection> get sampleCollections => [
    LexiconCollection(
      id: 'sample_col_gre',
      name: 'GRE Master Vocabulary',
      colorValue: 0xFF6366F1,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    LexiconCollection(
      id: 'sample_col_stoic',
      name: 'Stoic Wisdom & Philosophy',
      colorValue: 0xFFF59E0B,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  static List<LexiconEntry> getSampleEntries() {
    final now = DateTime.now();

    return [
      // ═══════════════════════════════════════════════════════════════════════
      // 1. WORDS (10 items)
      // ═══════════════════════════════════════════════════════════════════════
      LexiconEntry(
        id: 'sample_word_1',
        term: 'Serendipity',
        definition:
            'Occurrence of events by chance in a happy or beneficial way.',
        type: LexiconType.word,
        examples: ['Finding that antique bookstore was pure serendipity.'],
        notes: 'Coined by Horace Walpole in 1754.',
        tags: ['vocab', 'advanced', 'happiness'],
        collectionIds: ['sample_col_gre'],
        isFavorite: true,
        createdAt: now.subtract(const Duration(minutes: 10)),
      ),
      LexiconEntry(
        id: 'sample_word_2',
        term: 'Ephemeral',
        definition: 'Lasting for a very short time; transitory.',
        type: LexiconType.word,
        examples: ['Fame in the digital era can be strikingly ephemeral.'],
        notes: 'From Greek ephemeros, meaning lasting only a day.',
        tags: ['literary', 'philosophy', 'time'],
        collectionIds: ['sample_col_gre'],
        isFavorite: false,
        createdAt: now.subtract(const Duration(minutes: 25)),
      ),
      LexiconEntry(
        id: 'sample_word_3',
        term: 'Mellifluous',
        definition: 'Sweet or musical; pleasant to hear.',
        type: LexiconType.word,
        examples: ['Her mellifluous voice captivated the entire auditorium.'],
        notes: 'From Latin mel (honey) and fluere (to flow).',
        tags: ['sound', 'aesthetic', 'vocab'],
        collectionIds: ['sample_col_gre'],
        isFavorite: false,
        createdAt: now.subtract(const Duration(minutes: 40)),
      ),
      LexiconEntry(
        id: 'sample_word_4',
        term: 'Petrichor',
        definition:
            'The pleasant, earthy scent that accompanies the first rain after a dry spell.',
        type: LexiconType.word,
        examples: [
          'The sweet petrichor filled the evening breeze after months of summer drought.',
        ],
        notes: 'Coined in 1964 by Australian researchers.',
        tags: ['nature', 'sensory', 'weather'],
        collectionIds: [],
        isFavorite: true,
        createdAt: now.subtract(const Duration(minutes: 55)),
      ),
      LexiconEntry(
        id: 'sample_word_5',
        term: 'Ineffable',
        definition:
            'Too great, powerful, or beautiful to be expressed in words.',
        type: LexiconType.word,
        examples: [
          'Standing atop the Himalayan summit gave him a sense of ineffable wonder.',
        ],
        notes: 'Frequently used in mystical and philosophical texts.',
        tags: ['emotions', 'spirituality', 'advanced'],
        collectionIds: ['sample_col_gre'],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 1, minutes: 15)),
      ),
      LexiconEntry(
        id: 'sample_word_6',
        term: 'Sycophant',
        definition:
            'A person who acts obsequiously toward someone important in order to gain advantage.',
        type: LexiconType.word,
        examples: [
          'Surrounded by sycophants, the emperor never heard an honest critique.',
        ],
        notes: 'Often tested on GRE, SAT, and vocabulary exams.',
        tags: ['character', 'politics', 'vocabulary'],
        collectionIds: ['sample_col_gre'],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 1, minutes: 40)),
      ),
      LexiconEntry(
        id: 'sample_word_7',
        term: 'Equanimity',
        definition:
            'Mental calmness, composure, and evenness of temper, especially in a difficult situation.',
        type: LexiconType.word,
        examples: [
          'She accepted both praise and harsh criticism with admirable equanimity.',
        ],
        notes: 'Core virtue in Stoic and Buddhist philosophy.',
        tags: ['stoicism', 'virtue', 'mindset'],
        collectionIds: ['sample_col_stoic'],
        isFavorite: true,
        createdAt: now.subtract(const Duration(hours: 2, minutes: 10)),
      ),
      LexiconEntry(
        id: 'sample_word_8',
        term: 'Ubiquitous',
        definition: 'Present, appearing, or found everywhere simultaneously.',
        type: LexiconType.word,
        examples: ['Smartphones have become ubiquitous across the globe.'],
        notes: 'Derived from Latin ubique, meaning everywhere.',
        tags: ['technology', 'daily', 'modern'],
        collectionIds: ['sample_col_gre'],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 2, minutes: 45)),
      ),
      LexiconEntry(
        id: 'sample_word_9',
        term: 'Luminescence',
        definition: 'Emission of light by a substance not resulting from heat.',
        type: LexiconType.word,
        examples: [
          'Deep-sea jellyfish display mesmerizing bioluminescence in the abyss.',
        ],
        notes: 'Includes fluorescence and phosphorescence.',
        tags: ['science', 'nature', 'visual'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 3, minutes: 20)),
      ),
      LexiconEntry(
        id: 'sample_word_10',
        term: 'Resilience',
        definition:
            'The capacity to withstand or recover quickly from difficult conditions.',
        type: LexiconType.word,
        examples: [
          'The team demonstrated remarkable resilience throughout the challenging season.',
        ],
        notes: 'From Latin resilire, to spring back.',
        tags: ['character', 'psychology', 'growth'],
        collectionIds: ['sample_col_stoic'],
        isFavorite: true,
        createdAt: now.subtract(const Duration(hours: 4)),
      ),

      // ═══════════════════════════════════════════════════════════════════════
      // 2. PHRASES (10 items)
      // ═══════════════════════════════════════════════════════════════════════
      LexiconEntry(
        id: 'sample_phrase_1',
        term: 'Ad infinitum',
        definition: 'Again and again in the same way; forever or without end.',
        type: LexiconType.phrase,
        examples: [
          'They debated the proposed policy ad infinitum without reaching consensus.',
        ],
        notes: 'Latin phrase widely used in legal and academic arguments.',
        tags: ['latin', 'formal', 'logic'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 4, minutes: 30)),
      ),
      LexiconEntry(
        id: 'sample_phrase_2',
        term: 'Bona fide',
        definition: 'Undertaken in good faith; genuine, real, without fraud.',
        type: LexiconType.phrase,
        examples: [
          'She made a bona fide effort to resolve the dispute before filing suit.',
        ],
        notes: 'Latin for "with good faith".',
        tags: ['law', 'formal', 'business'],
        collectionIds: [],
        isFavorite: true,
        createdAt: now.subtract(const Duration(hours: 5)),
      ),
      LexiconEntry(
        id: 'sample_phrase_3',
        term: 'Carpe diem',
        definition:
            'Seize the day; make the most of the present moment with little concern for the future.',
        type: LexiconType.phrase,
        examples: [
          'Remember carpe diem when hesitating to pursue your passions.',
        ],
        notes: 'Originated in Roman poet Horace’s Odes (23 BC).',
        tags: ['latin', 'motivation', 'philosophy'],
        collectionIds: ['sample_col_stoic'],
        isFavorite: true,
        createdAt: now.subtract(const Duration(hours: 5, minutes: 40)),
      ),
      LexiconEntry(
        id: 'sample_phrase_4',
        term: 'Status quo',
        definition:
            'The existing state of affairs, especially regarding social, cultural, or political issues.',
        type: LexiconType.phrase,
        examples: [
          'The innovative startup actively sought to disrupt the industry status quo.',
        ],
        notes: 'Short for status quo ante (the state before the war).',
        tags: ['politics', 'business', 'society'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 6, minutes: 15)),
      ),
      LexiconEntry(
        id: 'sample_phrase_5',
        term: 'Tabula rasa',
        definition:
            'An absence of preconceived ideas or predetermined goals; a clean slate.',
        type: LexiconType.phrase,
        examples: [
          'The new design lead treated the legacy product architecture as a tabula rasa.',
        ],
        notes:
            'Popularized by John Locke in An Essay Concerning Human Understanding.',
        tags: ['philosophy', 'psychology', 'education'],
        collectionIds: ['sample_col_stoic'],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 7)),
      ),
      LexiconEntry(
        id: 'sample_phrase_6',
        term: 'De facto',
        definition:
            'Existing in fact or practice, whether recognized by formal law or not.',
        type: LexiconType.phrase,
        examples: [
          'Although not officially the director, he became the de facto leader of the initiative.',
        ],
        notes: 'Contrast with de jure (by legal right).',
        tags: ['law', 'business', 'governance'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 8)),
      ),
      LexiconEntry(
        id: 'sample_phrase_7',
        term: 'Modus operandi',
        definition:
            'A particular way or method of doing something, especially one that is distinctive.',
        type: LexiconType.phrase,
        examples: [
          'The detective recognized the serial burglar by his signature modus operandi.',
        ],
        notes: 'Often abbreviated as M.O.',
        tags: ['investigation', 'methodology', 'formal'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 9)),
      ),
      LexiconEntry(
        id: 'sample_phrase_8',
        term: 'Prima facie',
        definition:
            'Based on first impression; accepted as correct until proved otherwise.',
        type: LexiconType.phrase,
        examples: [
          'The bank statements provided prima facie evidence of financial fraud.',
        ],
        notes: 'Latin meaning "at first face".',
        tags: ['law', 'logic', 'formal'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 10)),
      ),
      LexiconEntry(
        id: 'sample_phrase_9',
        term: 'Quid pro quo',
        definition:
            'A favor, benefit, or advantage granted in return for something of equivalent value.',
        type: LexiconType.phrase,
        examples: [
          'The treaty negotiation involved an intricate quid pro quo between the nations.',
        ],
        notes: 'Latin for "something for something".',
        tags: ['negotiation', 'business', 'politics'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 11)),
      ),
      LexiconEntry(
        id: 'sample_phrase_10',
        term: 'Vox populi',
        definition:
            'The opinion or beliefs of the majority; the voice of the general public.',
        type: LexiconType.phrase,
        examples: [
          'Editorial columns often claim to speak directly for the vox populi.',
        ],
        notes:
            'From the proverb "Vox populi, vox Dei" (The voice of the people is the voice of God).',
        tags: ['journalism', 'politics', 'society'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 12)),
      ),

      // ═══════════════════════════════════════════════════════════════════════
      // 3. IDIOMS (10 items)
      // ═══════════════════════════════════════════════════════════════════════
      LexiconEntry(
        id: 'sample_idiom_1',
        term: 'Bite the bullet',
        definition:
            'To face a grim or difficult situation with fortitude and courage.',
        type: LexiconType.idiom,
        examples: [
          'She decided to bite the bullet and give the critical presentation to senior executives.',
        ],
        notes:
            'Historically arose from soldiers biting lead bullets during battlefield surgery.',
        tags: ['courage', 'action', 'colloquial'],
        collectionIds: [],
        isFavorite: true,
        createdAt: now.subtract(const Duration(hours: 13)),
      ),
      LexiconEntry(
        id: 'sample_idiom_2',
        term: 'Break the ice',
        definition:
            'To relieve tension, stiffness, or awkwardness in a social gathering.',
        type: LexiconType.idiom,
        examples: [
          'A humorous trivia question helped break the ice among unfamiliar teammates.',
        ],
        notes: 'Refers to icebreaker ships carving paths for other vessels.',
        tags: ['conversation', 'social', 'humor'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 14)),
      ),
      LexiconEntry(
        id: 'sample_idiom_3',
        term: 'Burn the midnight oil',
        definition:
            'To work, study, or read late into the night with intense focus.',
        type: LexiconType.idiom,
        examples: [
          'Engineers burned the midnight oil to deploy the patch before market opening.',
        ],
        notes:
            'Refers to burning oil in lamps before the advent of electricity.',
        tags: ['effort', 'work', 'study'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 15)),
      ),
      LexiconEntry(
        id: 'sample_idiom_4',
        term: 'Hit the nail on the head',
        definition:
            'To identify or describe the exact root cause of a problem accurately.',
        type: LexiconType.idiom,
        examples: [
          'Her concise audit of customer churn hit the nail on the head.',
        ],
        notes: 'Craftsmanship idiom dating back to the 16th century.',
        tags: ['accuracy', 'feedback', 'communication'],
        collectionIds: [],
        isFavorite: true,
        createdAt: now.subtract(const Duration(hours: 16)),
      ),
      LexiconEntry(
        id: 'sample_idiom_5',
        term: 'Let the cat out of the bag',
        definition:
            'To reveal a secret or confidential piece of information, often accidentally.',
        type: LexiconType.idiom,
        examples: [
          'David accidentally let the cat out of the bag regarding Maya’s promotion.',
        ],
        notes:
            'Origin debated; commonly linked to marketplace livestock deception.',
        tags: ['secrets', 'mistake', 'social'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 17)),
      ),
      LexiconEntry(
        id: 'sample_idiom_6',
        term: 'Piece of cake',
        definition: 'A task or job that is remarkably simple and easy to do.',
        type: LexiconType.idiom,
        examples: [
          'After weeks of exhaustive study, the introductory exam was a piece of cake.',
        ],
        notes: 'Originated in 1930s colloquial American and British English.',
        tags: ['ease', 'confidence', 'informal'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 18)),
      ),
      LexiconEntry(
        id: 'sample_idiom_7',
        term: "Steal someone's thunder",
        definition:
            'To pre-empt someone by doing or saying what they had planned, taking the praise.',
        type: LexiconType.idiom,
        examples: [
          'Announcing the product launch ahead of her keynote stole her thunder.',
        ],
        notes:
            'Attributed to dramatist John Dennis in 1709 whose theater thunder device was copied.',
        tags: ['competition', 'workplace', 'recognition'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 19)),
      ),
      LexiconEntry(
        id: 'sample_idiom_8',
        term: 'Take with a grain of salt',
        definition:
            'To view something with a healthy degree of skepticism rather than full acceptance.',
        type: LexiconType.idiom,
        examples: [
          'Sensational online headlines should always be taken with a grain of salt.',
        ],
        notes:
            'From Latin "cum grano salis", mentioned by Pliny the Elder in 77 AD.',
        tags: ['skepticism', 'wisdom', 'critical-thinking'],
        collectionIds: ['sample_col_stoic'],
        isFavorite: true,
        createdAt: now.subtract(const Duration(hours: 20)),
      ),
      LexiconEntry(
        id: 'sample_idiom_9',
        term: 'Through the grapevine',
        definition:
            'Via gossip, informal hearsay, or rumors passed from person to person.',
        type: LexiconType.idiom,
        examples: [
          'I heard through the grapevine that a major merger is being finalized.',
        ],
        notes:
            'Traced back to the American Civil War telegraph lines that looked like grapevines.',
        tags: ['rumors', 'workplace', 'communication'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 21)),
      ),
      LexiconEntry(
        id: 'sample_idiom_10',
        term: 'Under the weather',
        definition:
            'Feeling slightly ill, indisposed, or lacking usual energy.',
        type: LexiconType.idiom,
        examples: [
          'He skipped the dinner banquet because he was feeling a bit under the weather.',
        ],
        notes:
            'Nautical origin: sailors retreated below deck in bad weather to rest.',
        tags: ['health', 'daily', 'courtesy'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(hours: 22)),
      ),

      // ═══════════════════════════════════════════════════════════════════════
      // 4. QUOTES (10 items)
      // ═══════════════════════════════════════════════════════════════════════
      LexiconEntry(
        id: 'sample_quote_1',
        term: 'Knowing You Know Nothing',
        definition: 'The only true wisdom is in knowing you know nothing.',
        type: LexiconType.quote,
        examples: ['Socrates'],
        notes: 'Reflecting the Socratic paradox recorded in Plato’s Apology.',
        tags: ['philosophy', 'wisdom', 'humility'],
        collectionIds: ['sample_col_stoic'],
        isFavorite: true,
        createdAt: now.subtract(const Duration(hours: 23)),
      ),
      LexiconEntry(
        id: 'sample_quote_2',
        term: 'Be The Change',
        definition: 'Be the change that you wish to see in the world.',
        type: LexiconType.quote,
        examples: ['Mahatma Gandhi'],
        notes: 'Inspiring personal agency and moral leadership.',
        tags: ['inspiration', 'leadership', 'action'],
        collectionIds: [],
        isFavorite: true,
        createdAt: now.subtract(const Duration(days: 1, hours: 1)),
      ),
      LexiconEntry(
        id: 'sample_quote_3',
        term: 'Opportunity in Difficulty',
        definition: 'In the middle of difficulty lies opportunity.',
        type: LexiconType.quote,
        examples: ['Albert Einstein'],
        notes: 'Encouraging a growth mindset during adversity.',
        tags: ['optimism', 'science', 'perseverance'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(days: 1, hours: 2)),
      ),
      LexiconEntry(
        id: 'sample_quote_4',
        term: 'The Power of Persistence',
        definition:
            'It does not matter how slowly you go as long as you do not stop.',
        type: LexiconType.quote,
        examples: ['Confucius'],
        notes: 'Timeless Eastern philosophy on continuous steady progress.',
        tags: ['persistence', 'discipline', 'life'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(days: 1, hours: 3)),
      ),
      LexiconEntry(
        id: 'sample_quote_5',
        term: 'The Unexamined Life',
        definition: 'The unexamined life is not worth living.',
        type: LexiconType.quote,
        examples: ['Socrates'],
        notes: 'Uttered at Socrates’ trial in Athens.',
        tags: ['philosophy', 'reflection', 'truth'],
        collectionIds: ['sample_col_stoic'],
        isFavorite: true,
        createdAt: now.subtract(const Duration(days: 1, hours: 4)),
      ),
      LexiconEntry(
        id: 'sample_quote_6',
        term: 'Stay Hungry, Stay Foolish',
        definition:
            'Stay hungry. Stay foolish. Never settle for what is comfortable.',
        type: LexiconType.quote,
        examples: ['Steve Jobs (Stanford Commencement, 2005)'],
        notes:
            'Originally published on the back cover of the Whole Earth Catalog in 1974.',
        tags: ['innovation', 'curiosity', 'ambition'],
        collectionIds: [],
        isFavorite: true,
        createdAt: now.subtract(const Duration(days: 1, hours: 5)),
      ),
      LexiconEntry(
        id: 'sample_quote_7',
        term: 'Happiness Depends on Ourselves',
        definition: 'Happiness depends upon ourselves.',
        type: LexiconType.quote,
        examples: ['Aristotle'],
        notes: 'From Nicomachean Ethics regarding eudaimonia.',
        tags: ['stoicism', 'happiness', 'mindset'],
        collectionIds: ['sample_col_stoic'],
        isFavorite: false,
        createdAt: now.subtract(const Duration(days: 1, hours: 6)),
      ),
      LexiconEntry(
        id: 'sample_quote_8',
        term: 'Not All Who Wander',
        definition: 'Not all those who wander are lost.',
        type: LexiconType.quote,
        examples: ['J.R.R. Tolkien (The Fellowship of the Ring)'],
        notes: 'From the poem "All that is gold does not glitter".',
        tags: ['literature', 'journey', 'adventure'],
        collectionIds: [],
        isFavorite: true,
        createdAt: now.subtract(const Duration(days: 1, hours: 7)),
      ),
      LexiconEntry(
        id: 'sample_quote_9',
        term: 'A Why to Live',
        definition: 'He who has a why to live can bear almost any how.',
        type: LexiconType.quote,
        examples: ['Friedrich Nietzsche'],
        notes:
            'Quoted extensively by Viktor Frankl in Man’s Search for Meaning.',
        tags: ['meaning', 'resilience', 'existentialism'],
        collectionIds: ['sample_col_stoic'],
        isFavorite: true,
        createdAt: now.subtract(const Duration(days: 1, hours: 8)),
      ),
      LexiconEntry(
        id: 'sample_quote_10',
        term: 'Ultimate Sophistication',
        definition: 'Simplicity is the ultimate sophistication.',
        type: LexiconType.quote,
        examples: ['Leonardo da Vinci'],
        notes:
            'Guiding principle in timeless architecture, design, and writing.',
        tags: ['design', 'art', 'clarity'],
        collectionIds: [],
        isFavorite: false,
        createdAt: now.subtract(const Duration(days: 1, hours: 9)),
      ),
    ];
  }

  /// Inserts or updates sample collections and entries into [db].
  /// Skips any entry where a custom (non-sample) user entry already exists with the same term.
  /// Updates existing sample entries to ensure fresh content without duplicates.
  /// Returns a [SampleLoadResult] detailing added, updated, and skipped counts.
  static Future<SampleLoadResult> loadSampleData(DatabaseService db) async {
    // 1. Add sample collections if they do not exist
    final existingCollections = db.getCollections();
    final existingColIds = existingCollections.map((c) => c.id).toSet();

    for (final col in sampleCollections) {
      if (!existingColIds.contains(col.id)) {
        await db.saveCollection(col);
      }
    }

    // 2. Add or update sample entries
    final entries = getSampleEntries();
    int addedCount = 0;
    int updatedCount = 0;
    int skippedCount = 0;

    for (final entry in entries) {
      try {
        final duplicate = db.findDuplicateEntry(
          entry.term,
          entry.type,
          excludeEntryId: entry.id,
          incomingCollectionIds: entry.collectionIds,
        );

        // If duplicate exists and is NOT a sample entry, preserve user's custom entry
        if (duplicate != null && !duplicate.id.startsWith(sampleIdPrefix)) {
          skippedCount++;
          continue;
        }

        // Check if this exact sample ID is already in the database
        final existing = db.entriesBox.get(entry.id);
        if (existing != null) {
          await db.entriesBox.put(entry.id, entry);
          updatedCount++;
        } else {
          await db.saveEntry(entry);
          addedCount++;
        }
      } catch (_) {
        skippedCount++;
      }
    }

    return SampleLoadResult(
      added: addedCount,
      updated: updatedCount,
      skipped: skippedCount,
    );
  }

  static const String sampleIdPrefix = 'sample_';

  /// Removes all sample entries and sample collections from [db].
  /// Returns the number of sample entries deleted.
  static Future<int> deleteSampleData(DatabaseService db) async {
    // 1. Delete all sample entries
    final entries = db
        .getEntries()
        .where((e) => e.id.startsWith(sampleIdPrefix))
        .toList();
    for (final entry in entries) {
      await db.deleteEntry(entry.id);
    }

    // 2. Delete all sample collections
    final collections = db
        .getCollections()
        .where(
          (c) =>
              c.id.startsWith(sampleIdPrefix) ||
              c.name == 'GRE Master Vocabulary' ||
              c.name == 'Stoic Wisdom & Philosophy',
        )
        .toList();
    for (final col in collections) {
      await db.deleteCollection(col.id);
    }

    return entries.length;
  }

  /// Returns true if any sample entries or collections exist in [db].
  static bool hasSampleData(DatabaseService db) {
    return db.getEntries().any((e) => e.id.startsWith(sampleIdPrefix)) ||
        db.getCollections().any((c) => c.id.startsWith(sampleIdPrefix));
  }
}
